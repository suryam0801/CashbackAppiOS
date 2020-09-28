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
    
    //MARK: Cashback Helpers
    static func cashbackDisplayText (price:Double) -> String {
        return price <= 500 ? "50 - 150₹ cashback!" : "100 - 250₹ cashback!"
    }
    
    static func totalCashbackCalculator (cashback:inout [Double], price:Double, itemQuantity:Double) {
        if price <= 500 {
            cashback[0] += (50 * itemQuantity)
            cashback[1] += (150 * itemQuantity)
        } else {
            cashback[0] += (100 * itemQuantity)
            cashback[1] += (200 * itemQuantity)
        }
    }
    
    static func cashbackArraySetter (cashback: inout [Double], price: Double) {
        cashback[0] = price <= 500 ? 50 : 150
        cashback[1] = price <= 500 ? 100 : 200
    }
    
    static func returnCashbackLowerEnd (price:Double) -> Int {
        let amountToReturn = price <= 500 ? 50 : 100
        return amountToReturn
    }
    
    static func returnCashbackUpperEnd (price:Double) -> Int {
        let amountToReturn = price <= 500 ? 100 : 200
        return amountToReturn
    }
    
    //MARK: User Helpers
    static func storeCustomerToDefaults (_ customerObj: Customer) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(customerObj) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedUser")
        }
        
        customer = customerObj
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
        givenCashback = randomCashback
        
        for item in tempCartItems! {
            let tempOrder = Order(id: FirebasePushKeyHelper.getPushKey(), customerId: customer?.id, transactionId: paymentId, totalAmount: item.quantity * item.price, timestamp: Date().millisecondsSince1970, address: customer!.address, refundStatus: nil, trackingId: nil, cashback: Double(randomCashback), cashbackStatus: false, itemId: item.itemId, itemName: item.name, itemPrice: item.price, itemColor: item.color, itemSize: item.size, itemQuantity: item.quantity, itemPhotos: item.photos, storeId: item.storeIds)
            
            orderList.append(tempOrder)
        }

        DBWriteHelper.writeOrders(orders: orderList)
    }
    
    static func groupingCashbackByTransactions (ordersList:[Order]) -> [Order] {
        var transactionIds:[String] = []
        var tempOrderList:[Order] = []
        
        for order in ordersList {
            print(transactionIds)
            print(order.transactionId)
            if !transactionIds.contains(order.transactionId) {
                tempOrderList.append(order)
                transactionIds.append(order.transactionId)
            }
        }
        
        return tempOrderList
    }
    
    static func totalCashbackAmount (orderList:[Order]) -> Double {
        var cashbackAmount:Double = 0
        
        for order in orderList {
            cashbackAmount += order.cashback
        }
        
        return cashbackAmount
    }

    //MARK: CART HELPER
    static func quantityIncrement (quantity:inout Double, cartItemPrice:Double, currentMRP:inout Double, cashback:inout [Double]) {
        if quantity != 10 {
            quantity += 1
            currentMRP += cartItemPrice
            cashback[0] += Double(returnCashbackLowerEnd(price: cartItemPrice))
            cashback[1] += Double(returnCashbackUpperEnd(price: cartItemPrice))
        }
    }
    
    static func quantityDecrement (quantity:inout Double, cartItemPrice:Double, currentMRP:inout Double, cashback:inout [Double]) {
        if quantity != 1 {
            quantity -= 1
            currentMRP -= cartItemPrice
            cashback[0] -= Double(returnCashbackLowerEnd(price: cartItemPrice))
            cashback[1] -= Double(returnCashbackUpperEnd(price: cartItemPrice))
        }
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
    
}
