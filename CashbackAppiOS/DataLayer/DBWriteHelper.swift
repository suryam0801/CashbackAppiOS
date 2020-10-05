//
//  DBWriteHelper.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseMessaging

class DBWriteHelper {
    
    //MARK:- USER DATA
    func createNewCustomer (userObj:Customer, _ completion: @escaping  ((_ userCreated:Bool)->())) {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        var tempUserObj = userObj

        func writeCustomer () {
            dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(tempUserObj.id).setValue(Helpers.asDictionary(object: tempUserObj)) {
                (error:Error?, ref:DatabaseReference) in
                if error != nil {
                    completion(false)
                } else {
                    Helpers.storeCustomerToDefaults(tempUserObj)
                    completion(true)
                }
            }
        }

        if let token = Messaging.messaging().fcmToken {
            tempUserObj.deviceToken = token
            writeCustomer()
        }
    }

    func updateToken (newToken:String) {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("deviceToken").setValue(newToken)
        Helpers.storeCustomerToDefaults(customer!)
    }

    func updateAddresses () {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("address").setValue(customer!.address)
        Helpers.storeCustomerToDefaults(customer!)
    }

    //MARK: Cart Data
    func addToCart (cartItem:CartItem) {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        var tempCartItem = cartItem
        if customer?.cart?[cartItem.itemId] != nil {
            customer?.cart![cartItem.itemId]?.quantity += 1
            tempCartItem = customer?.cart[cartItem.itemId] as! CartItem
        }
        
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart").child(cartItem.itemId).setValue(Helpers.asDictionary(object: tempCartItem))

        var userCart = customer?.cart ?? [String:CartItem]()
        userCart[cartItem.itemId] = tempCartItem
        customer?.cart = userCart
        Helpers.storeCustomerToDefaults(customer!)
    }

    func removeFromCart (cartItemId:String) {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart").child(cartItemId).removeValue()

        customer?.cart[cartItemId] = nil
        Helpers.storeCustomerToDefaults(customer!)
    }
    
    func updateItemQuantity (cartItemId:String, newQuantity:Double) {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart").child(cartItemId).child("quantity").setValue(newQuantity)
        customer?.cart[cartItemId]?.quantity = newQuantity
        Helpers.storeCustomerToDefaults(customer!)
    }
    
    //MARK: ORDERS DATA
    func writeOrders (orders:[Order]) {
        
        guard SkipChecker().skip == false else {
            SkipChecker().makeUserLogin()
            return
        }
        
        for order in orders {
            dbInstance.db.reference(withPath: DBReferenceNames.ORDERS_REF_NAME).child(order.id).setValue(Helpers.asDictionary(object: order))
            
            removeFromCart(cartItemId: order.itemId)
        }
    }
}
