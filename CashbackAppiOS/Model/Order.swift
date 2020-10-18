//
//  Order.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 13/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class Order : Codable {
    internal init(id: String, customerId: String? = nil, customerName: String? = nil, customerPhnNumber: String? = nil, transactionId: String? = nil, totalAmount: Double? = nil, timestamp: Int64? = nil, address: String? = nil, promocodeApplied: String? = nil, refundStatus: String? = nil, trackingId: String? = nil, cashback: Double? = nil, cashbackStatus: Bool? = nil, itemId: String? = nil, itemName: String? = nil, itemPrice: Double? = nil, itemColor: String? = nil, itemSize: String? = nil, itemQuantity: Double? = nil, itemPhotos: [String]? = nil, storeId: String? = nil) {
        self.id = id
        self.customerId = customerId
        self.customerName = customerName
        self.customerPhnNumber = customerPhnNumber
        self.transactionId = transactionId
        self.totalAmount = totalAmount
        self.timestamp = timestamp
        self.address = address
        self.promocodeApplied = promocodeApplied
        self.refundStatus = refundStatus
        self.trackingId = trackingId
        self.cashback = cashback
        self.cashbackStatus = cashbackStatus
        self.itemId = itemId
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemColor = itemColor
        self.itemSize = itemSize
        self.itemQuantity = itemQuantity
        self.itemPhotos = itemPhotos
        self.storeId = storeId
    }
    
    
    var id: String
    var customerId:String!
    var customerName: String!
    var customerPhnNumber: String!
    var transactionId:String!
    var totalAmount:Double!
    var timestamp:Int64!
    var address:String!
    var promocodeApplied:String!
    //Tracking Status
    var refundStatus:String! // requested/refunded
    var trackingId:String?
    var cashback:Double!
    var cashbackStatus:Bool! // true/false
    //Item Properties
    var itemId:String!
    var itemName:String!
    var itemPrice:Double!
    var itemColor:String!
    var itemSize:String!
    var itemQuantity:Double!
    var itemPhotos:[String]!
    var storeId:String!
}
