//
//  SkipChecker.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 05/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class SkipChecker {
    var skip = UserDefaults.standard.value(forKey: "skip") as? Bool ?? false
    
    func makeUserLogin () {
        UserDefaults.standard.set(false, forKey: "skip")
        NotificationCenter.default.post(name: NSNotification.Name("skipChange"), object: nil)
    }
}
