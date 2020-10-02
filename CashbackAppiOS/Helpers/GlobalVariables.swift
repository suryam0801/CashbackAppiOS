//
//  GlobalVariables.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

var customer:Customer? = Helpers.retrieveStoredCustomer()

var types = ["All","Men","Women","Kids"]

var transactionId:String?
var tempCartItems:[CartItem]?
var tempCashback:[Double]?
var givenCashback:Int?
var tempCartTotal:Double?

var cashbackAmount:CashbackAmount?
var retrievedPromoCodes:[String:Bool]?
var promoCode:String?
