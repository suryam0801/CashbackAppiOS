//
//  CraftItem.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 20/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

struct CraftItem: Codable, Identifiable {
    var id:String
    var name:String!
    var maxCashback:Double!
    var minCashback:Double!
    var price:Double!
    var category:[String]!
    var storeIds:String!
    var photos:[String]!
    var photoNeeded:Bool!
    var options:[String:[String]]!
    var TextEntry:[String:String]!
}
