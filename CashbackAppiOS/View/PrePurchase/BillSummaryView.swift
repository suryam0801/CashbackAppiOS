//
//  BillSummaryView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 28/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct BillSummaryView: View {
    @Binding var cartItems:[CartItem]
    @Binding var cashback:[Double]
    @Binding var totalMRP:Double
    
    var body: some View {
        VStack {
            Text("Cart Details (\(cartItems.count) items)").font(.subheadline).bold()
            
            Divider()
            
            HStack {
                Text("Total MRP:").font(.subheadline)
                Spacer()
                Text("\(totalMRP.removeZerosFromEnd())₹").font(.subheadline)
            }
            
            HStack {
                Text("Cashback:").font(.subheadline)
                Spacer()
                Text("\(cashback[0].removeZerosFromEnd())₹ - \(cashback[1].removeZerosFromEnd())₹").font(.subheadline)
            }

            HStack {
                Text("Platform Handling Fee:").font(.subheadline)
                Spacer()
                Text("99₹").strikethrough().font(.subheadline)
                Text("FREE").foregroundColor(Color(UIColor.acceptColorGreen)).font(.subheadline)
            }

            HStack {
                Text("Delivery Fee:").font(.subheadline)
                Spacer()
                Text("30₹").strikethrough().font(.subheadline)
                Text("FREE").foregroundColor(Color(UIColor.acceptColorGreen)).font(.subheadline)
            }

            Divider()

            HStack {
                Text("Amount Due: ").font(.headline).bold()
                Spacer()
                Text("\(totalMRP.removeZerosFromEnd())₹").font(.subheadline)
            }
        }
    }
}
