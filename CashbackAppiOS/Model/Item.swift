//
//  Item.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

struct Item: Codable, Identifiable {
    var id:String
    var name:String!
    var maxCashback:Double!
    var minCashback:Double!
    var price:Double!
    var category:[String]!
    var storeIds:String!
    var stock:[String:Int]!
    var photos:[String]!
    var color:[String]!
    var sizes:[String]!
}
