//
//  CashbackAmmountViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 28/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import CodableFirebase

class CashbackAmountViewModel {
    
    func fetchAmount (_ completion: @escaping ((_ userExists:Bool)->())) {
        
        let DBHelper = DatabaseReadHelper()
        
        DBHelper.fetchSingleValueFromDB(dbInstance.db.reference(withPath: DBReferenceNames.CASHBACK_AMOUNT_REF_NAME)) { (snapshot) in
            do{
                cashbackAmount = try FirebaseDecoder().decode(CashbackAmount.self, from: snapshot.value!)
                completion(true)
            } catch let error {
                print(error)
                completion(false)
            }
        }
    }
}
