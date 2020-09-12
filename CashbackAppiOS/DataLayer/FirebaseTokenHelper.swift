//
//  FirebaseTokenHelper.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import FirebaseMessaging

class FirebaseTokenHelper {
    static func getToken () -> String {
        return Messaging.messaging().fcmToken!
    }
}
