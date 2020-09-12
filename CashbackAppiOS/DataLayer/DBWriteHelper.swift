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
    static func createNewUser (userObj:Customer, _ completion: @escaping  ((_ userCreated:Bool)->())) {
        
        var tempUserObj = userObj
        
        func writeUser () {
            dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(tempUserObj.id).setValue(Helpers.asDictionary(object: tempUserObj)) {
                (error:Error?, ref:DatabaseReference) in
                if error != nil {
                    completion(false)
                } else {
                    Helpers.storeUserToUserDefaults(tempUserObj)
                    completion(true)
                }
            }
        }
        
        if let token = Messaging.messaging().fcmToken {
            tempUserObj.deviceToken = token
            writeUser()
        }
    }
    
    static func updateUser () {
        dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(user!.id).setValue(Helpers.asDictionary(object: user!))
        Helpers.storeUserToUserDefaults(user!)
    }
}
