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
    static func createNewCustomer (userObj:Customer, _ completion: @escaping  ((_ userCreated:Bool)->())) {
        
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
    
    static func updateToken (newToken:String) {
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("deviceToken").setValue(newToken)
        Helpers.storeCustomerToDefaults(customer!)
    }
    
    static func updateCustomer () {
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).setValue(Helpers.asDictionary(object: customer!))
        Helpers.storeCustomerToDefaults(customer!)
    }

    //MARK: Cart Data
    static func addToCart (cartItem:CartItem) {
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart").child(cartItem.itemId).setValue(Helpers.asDictionary(object: cartItem))

        var userCart = customer?.cart ?? [String:CartItem]()
        userCart[cartItem.itemId] = cartItem
        Helpers.storeCustomerToDefaults(customer!)
    }

    static func removeFromCart (cartItem:CartItem) {
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart").child(cartItem.itemId).removeValue()

        var userCart = customer?.cart ?? [String:CartItem]()
        userCart[cartItem.itemId] = nil
        Helpers.storeCustomerToDefaults(customer!)
    }
    
    static func updateItemQuantity (cartItemId:String, newQuantity:Int) {
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(customer!.id).child("cart").child(cartItemId).child("quantity").setValue(newQuantity)
        
        customer?.cart[cartItemId]?.quantity = newQuantity
        Helpers.storeCustomerToDefaults(customer!)
    }
}
