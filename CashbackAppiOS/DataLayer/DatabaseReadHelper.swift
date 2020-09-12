//
//  DatabaseReadHelper.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import Firebase

class DatabaseReadHelper {
    
    private var reader:DbReader?
    private var snapshotList:[DataSnapshot] = []
    
    func fetchFromDatabase(_ query:DatabaseQuery, completion: @escaping ((_ snapShotArray:[DataSnapshot])->())) {
        reader = DbReader(query)
        reader!.childEventListener { snapshot, returnStatus in
            self.snapshotList = SnapshotHelpers.snapshotListModifierHelper(self.snapshotList, returnStatus!, snapshot)
            completion(self.snapshotList)
        }
    }
    
    func fetchSingleValueFromDB (_ query:DatabaseQuery, completion: @escaping ((_ snapshot:DataSnapshot)->())) {
        DbReader(query).singleValueListener { snapshot in
            completion (snapshot)
        }
    }
    
    func fetchEventListenerFromDB (_ query:DatabaseQuery, completion: @escaping ((_ snapshot:DataSnapshot)->())) {
        reader = DbReader(query)
        reader!.valueEventListener { snapshot in
            completion (snapshot)
        }
    }
    
    func removeReader () {
        self.snapshotList.removeAll()
        reader!.removeListener(reader!)
    }
}
