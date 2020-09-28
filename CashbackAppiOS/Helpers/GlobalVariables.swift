//
//  GlobalVariables.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

var customer:Customer? = Helpers.retrieveStoredCustomer()

var sizes = ["XS","S","M","X","XL"]

var types = ["All","Men","Women","Kids"]

var transactionId:String?
var tempCartItems:[CartItem]?
var tempCashback:[Double]?
var givenCashback:Int?
var tempCartTotal:Double?

var emptyItem:Item = Item(id: "", name: "", price: 0, category: nil, storeIds: nil, stock: nil, photos: [""], color: nil, sizes: nil)

var cashbackAmount:CashbackAmount?
