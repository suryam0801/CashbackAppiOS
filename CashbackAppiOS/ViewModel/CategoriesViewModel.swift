//
//  CategoriesViewModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 08/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import CodableFirebase

class CategoriesViewModel{
    
    func fetchCategories (_ completion:@escaping ((_ categories:[String])->())) {
        
        let DBHelper = DatabaseReadHelper()
        
        DBHelper.fetchSingleValueFromDB(dbInstance.db.reference(withPath: DBReferenceNames.CATEGORIES_REF_NAME)) { (snapshot) in
            do{
                let categories = try FirebaseDecoder().decode([String].self, from: snapshot.value!)
                completion(categories)
            } catch let error {
                print(error)
            }
        }
    }
}
