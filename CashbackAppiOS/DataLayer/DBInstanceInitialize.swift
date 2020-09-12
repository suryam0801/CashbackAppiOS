//
//  DBInstanceInitialize.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import Firebase

let dbInstance = DBInstanceInitialize()

class DBInstanceInitialize {
    let db:Database
    
    init() {
        db = Database.database()
    }

}
