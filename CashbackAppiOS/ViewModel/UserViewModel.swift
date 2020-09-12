//
//  UserViewModel.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 17/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import CodableFirebase

class UserViewModel {
    
    func fetchUser (_ userId: String, _ completion: @escaping ((_ userExists:Bool)->())) {
        
        let DBHelper = DatabaseReadHelper()
        
        DBHelper.fetchSingleValueFromDB(dbInstance.db.reference(withPath: DBReferenceNames.USER_REF_NAME).child(userId)) { (snapshot) in
            do{
                let user:Customer = try FirebaseDecoder().decode(Customer.self, from: snapshot.value!)
                Helpers.storeUserToUserDefaults(user)
                completion(true)
            } catch let error {
                print(error)
                completion(false)
            }
        }
    }
}
