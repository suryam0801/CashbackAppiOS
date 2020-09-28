//
//  PromoCodeViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 28/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import CodableFirebase

class PromoCodeViewModel {
    func fetchPromoCodes () {
        
        let DBHelper = DatabaseReadHelper()
        
        DBHelper.fetchSingleValueFromDB(dbInstance.db.reference(withPath: DBReferenceNames.PROMOCODE_REF_NAME)) { (snapshot) in
            do{
                let promoCodes = try FirebaseDecoder().decode([String:Bool].self, from: snapshot.value!)
                retrievedPromoCodes = promoCodes
                
                for key in retrievedPromoCodes!.keys {
                    retrievedPromoCodes![key.lowercased()] = retrievedPromoCodes!.removeValue(forKey: key)
                }
                
            } catch let error {
                print(error)
            }
        }
    }
}
