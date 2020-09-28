//
//  CashbackAmountModel.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 28/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

struct CashbackAmount : Codable {
    internal init(amount: Int, purchases: Int) {
        self.amount = amount
        self.purchases = purchases
    }

    var amount:Int
    var purchases:Int
}
