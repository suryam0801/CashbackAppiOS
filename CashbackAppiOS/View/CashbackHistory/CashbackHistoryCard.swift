//
//  CashbackHistoryCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 15/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CashbackHistoryCard: View {
    var order:Order
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(order.cashback.removeZerosFromEnd())₹").font(.largeTitle).foregroundColor(Color.white)
                Text("\(Helpers.convertToDate(milisecond: order.timestamp))").foregroundColor(Color.white)
            }.padding(12)
            Spacer()
        }.background(Color(UIColor.pollForegroundBlue)).cornerRadius(4).padding(10)
    }
}
