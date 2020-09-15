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
var givenCashback:Int? = 50
var revealCashback:Int? = 100

var helperFlip:Bool?
var userFlip:String?
