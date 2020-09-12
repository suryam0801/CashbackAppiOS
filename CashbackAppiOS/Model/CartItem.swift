//
//  CartItem.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

struct CartItem : Codable {
    internal init(itemId: String? = nil, name: String? = nil, price: Int? = nil, photos: [String]? = nil, storeIds: String? = nil, color: String? = nil, size: String? = nil, quantity: String? = nil) {
        self.itemId = itemId
        self.name = name
        self.price = price
        self.photos = photos
        self.storeIds = storeIds
        self.color = color
        self.size = size
        self.quantity = quantity
    }
    
    var itemId:String!
    var name:String!
    var price: Int!
    var photos: [String]!
    var storeIds: String!
    var color: String!
    var size: String!
    var quantity:String!
}
