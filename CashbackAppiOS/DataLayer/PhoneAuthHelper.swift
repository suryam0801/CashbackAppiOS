//
//  PhoneAuthHelper.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import FirebaseAuth

class PhoneAuthHelper {
    
    static func validatePhoneNumber (_ phoneNumber:String) throws -> String {
        
        if phoneNumber.count < 10 {
            throw PhoneAuthError.phoneNumberTooShort
        }

        if phoneNumber.count > 10 {
            throw PhoneAuthError.phoneNumberTooLong
        }

        return phoneNumber
    }
    
    static func phoneNumberVerification(_ countryCode:String, _ phoneNumber:String, completion: @escaping ((_ verifiedNumber:Bool, _ userId:String?) -> ())) {
        PhoneAuthProvider.provider().verifyPhoneNumber(countryCode+phoneNumber, uiDelegate: nil) { (ID, err) in
            if err != nil{
                print("ERRROOORRRR")
                print(err as Any)
                completion(false, nil) //when phone verification fails
            } else {
                completion(true, ID) //when phone verification passes
            }
        }
    }
    
    static func registerUser (_ authenticationID:String,_ otp:String, completion: @escaping ((_ userVerified:Bool) -> ())) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: authenticationID, verificationCode: otp)
        
        Auth.auth().signIn(with: credential) { (res, err) in
            if err != nil {
                completion(false)
            } else {
                print("USER SUCCESSFULLY VERIFIED")
                completion(true)
            }
        }
    }
    
    static func getUserId () -> String {
        return Auth.auth().currentUser!.uid
    }
    
    static func signout() {
        do{
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "status")
            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        } catch let error {
            print(error)
        }
    }
    
}

enum PhoneAuthError : LocalizedError {
    case phoneNumberTooShort
    case phoneNumberTooLong
    
    var errorDescription: String?{
        switch self {
        case .phoneNumberTooLong:
            return "Your Phone Number is too long"
        case .phoneNumberTooShort:
            return "Your Phone Number is too short"
        }
    }
}
