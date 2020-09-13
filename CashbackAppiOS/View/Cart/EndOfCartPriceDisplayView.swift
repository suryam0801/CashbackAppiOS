//
//  EndOfCartPriceDisplayView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 13/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct EndOfCartPriceDisplayView: View {
    
    @Binding var cartItems:[CartItem]
    @Binding var cashback:[Int]
    @Binding var totalMRP:Int
    @State private var showPayment:Bool = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            
            Text("Cart Details (\(cartItems.count) items)").font(.subheadline).bold()
            
            Divider()
            
            HStack {
                Text("Total MRP:").font(.subheadline)
                Spacer()
                Text("\(totalMRP)₹").font(.subheadline)
            }
            
            HStack {
                Text("Cashback:").font(.subheadline)
                Spacer()
                Text("\(cashback[0])₹ - \(cashback[1])₹").font(.subheadline)
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
                Text("\(totalMRP)₹").font(.subheadline)
            }
            
            if self.showPayment {
                NavigationLink(destination: razorPayDisplay(), isActive: self.$showPayment) {
                    EmptyView()
                }
            }

            Button(action: {
                self.showPayment.toggle()
            }) {
                HStack {
                    Text("CHECKOUT").foregroundColor(Color.white)
                    Spacer()
                    Image("arrow.right").foregroundColor(Color.white)
                }.padding(12).background(Color(UIColor.acceptColorGreen)).cornerRadius(4)
            }

        }.padding().background(Color.white)
    }
}