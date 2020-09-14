//
//  Helpers.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum ChildReturnStatus {
    case added
    case changed
    case removed
}

class Helpers {
    
    //MARK: User Helpers
    static func storeCustomerToDefaults (_ userObj: Customer) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userObj) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedUser")
        }
        
        customer = userObj
    }

    static func retrieveStoredCustomer () -> Customer? {
        let defaults = UserDefaults.standard
        var user:Customer?
        if let savedPerson = defaults.object(forKey: "savedUser") as? Data {
            let decoder = JSONDecoder()
            user = try? decoder.decode(Customer.self, from: savedPerson)
        }
        return user
    }
    
    //MARK: Alert Helpers
    static func showImagePickerAlert (_ completion: @escaping ((_ sourceType:UIImagePickerController.SourceType) -> ())) -> Alert {
        let alert = Alert(title: Text("Choose Image"),
                          message: Text("How would you like to select your image?"),
                          primaryButton: .default(Text("Camera")) {
                            completion(.camera)},
                          secondaryButton: Alert.Button.default(Text("Gallery"), action: {
                            completion(.photoLibrary)
                          }))
        return alert
    }
    
    //MARK: Keyboard Helpers
    static func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    //MARK: Loose Helpers
    static func returnFlag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }

    static func asDictionary (object: Any) -> [String:Any] {
        
        let mirror = Mirror(reflecting: object)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            let val = value
            return (label, val)
        }).compactMap { $0 })
        return dict
    }
    
    //MARK: View Model Helpers
    static func makeItemsIntoGrid (itemList:[Item]) -> [Row] {
        var itemGrid:[Row] = []
        var counter = 0
        var row:Row = Row()
        
        for item in itemList {
            if counter % 2 == 0 {
                row.id = counter
                let tempCarry:[Item] = [item]
                row.rows = tempCarry
            } else {
                row.rows!.append(item)
                guard row != nil else { return itemGrid }
                itemGrid.append(row)
                
            }
            counter+=1
        }
        return itemGrid
    }
    
    static func makeOrderEntries (paymentId:String) {
        var orderList:[Order] = []
        
        let lowerCashback:Int = Int(tempCashback![0])
        let upperCashback:Int = Int(tempCashback![1])
        
        let randomCashback = Int.random(in: lowerCashback..<upperCashback)
        
        for item in tempCartItems! {
            let tempOrder = Order(id: FirebasePushKeyHelper.getPushKey(), customerId: customer?.id, transactionId: paymentId, totalAmount: item.quantity * item.price, timestamp: Date().millisecondsSince1970, address: "", refundStatus: nil, trackingId: nil, cashback: Double(randomCashback), cashbackStatus: false, itemId: item.itemId, itemName: item.name, itemPrice: item.price, itemColor: item.color, itemSize: item.size, itemQuantity: item.quantity, itemPhotos: item.photos, storeId: item.storeIds)
            
            orderList.append(tempOrder)
        }

        DBWriteHelper.writeOrders(orders: orderList)
    }

    //MARK: CART HELPER
    static func quantityIncrement (quantity:inout Double, cartItemPrice:Double, currentMRP:inout Double, cashback:inout [Double]) {
        if quantity != 10 {
            quantity += 1
            currentMRP += cartItemPrice
            cashback[0] += cartItemPrice <= 500 ? 50 : 100
            cashback[1] += cartItemPrice <= 500 ? 150 : 250
        }
    }
    
    static func quantityDecrement (quantity:inout Double, cartItemPrice:Double, currentMRP:inout Double, cashback:inout [Double]) {
        if quantity != 1 {
            quantity -= 1
            currentMRP -= cartItemPrice
            cashback[0] -= cartItemPrice <= 500 ? 50 : 100
            cashback[1] -= cartItemPrice <= 500 ? 150 : 250        }
    }
    
    //MARK: TIME HELPERS
    static func convertToDate (milisecond:Int64) -> String {
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: dateVar)
    }

    //MARK: TEXT HELPERS
    static func copyToClipBoard(textToCopy: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = textToCopy
    }
}
