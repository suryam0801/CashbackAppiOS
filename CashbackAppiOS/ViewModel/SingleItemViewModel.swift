//
//  SingleItemViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 04/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import CodableFirebase

class SingleItemViewModel {

    func fetchItem (_ itemId: String, _ completion: @escaping ((_ item:Item)->())) {

        let DBHelper = DatabaseReadHelper()

        DBHelper.fetchSingleValueFromDB(dbInstance.db.reference(withPath: DBReferenceNames.ITEM_REF_NAME).child(itemId)) { (snapshot) in
            do{
                let item:Item = try FirebaseDecoder().decode(Item.self, from: snapshot.value!)
                completion(item)
            } catch let error {
                print(error)
            }
        }
    }
}
