//
//  CartItem.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

struct CartItem : Codable {
    internal init(itemId: String? = nil, name: String? = nil, price: Double? = nil, maxCashback: Double? = nil, minCashback: Double? = nil, photos: [String]? = nil, storeIds: String? = nil, color: String? = nil, size: String? = nil, quantity: Double? = nil, photoNeeded: Bool? = nil, options: [String]? = nil, TextEntry: [String]? = nil) {
        self.itemId = itemId
        self.name = name
        self.price = price
        self.maxCashback = maxCashback
        self.minCashback = minCashback
        self.photos = photos
        self.storeIds = storeIds
        self.color = color
        self.size = size
        self.quantity = quantity
        self.photoNeeded = photoNeeded
        self.options = options
        self.TextEntry = TextEntry
    }
    
    var itemId:String!
    var name:String!
    var price: Double!
    var maxCashback: Double!
    var minCashback: Double!
    var photos: [String]!
    var storeIds: String!
    var color: String!
    var size: String!
    var quantity:Double!
    var photoNeeded:Bool!
    var options:[String]!
    var TextEntry:[String]!
}
