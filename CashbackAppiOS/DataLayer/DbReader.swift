//
//  DbReader.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import Firebase

class DbReader {

    private var REF_PATH:DatabaseQuery
    
    init (_ path:DatabaseQuery){
        self.REF_PATH = path
    }

    func childEventListener(completion: @escaping ((_ snapshot: DataSnapshot, _ action:ChildReturnStatus?)->())) {
        self.REF_PATH.observe(.childAdded, with: {snapshot in
            completion(snapshot, .added)
        })
        self.REF_PATH.observe(.childChanged, with: {snapshot in
            completion(snapshot, .changed)
        })
        self.REF_PATH.observe(.childRemoved, with: {snapshot in
            completion(snapshot, .removed)
        })
    }

    func singleValueListener(completion: @escaping ((_ snapshot: DataSnapshot)->())) {
        self.REF_PATH.observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot)
        }
    }
        
    func valueEventListener(completion: @escaping ((_ snapshot: DataSnapshot)->())) {
        self.REF_PATH.observe(.value) { (snapshot) in
            completion(snapshot)
        }
    }

    func removeListener (_ dbReader:DbReader) {
        dbReader.REF_PATH.removeAllObservers()
    }
}
