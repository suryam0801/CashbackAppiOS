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
    @Binding var cashback:[Double]
    @Binding var totalMRP:Double
    @State private var showPrePurchaseView:Bool = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            
            BillSummaryView(cartItems: self.$cartItems, cashback: self.$cashback, totalMRP: self.$totalMRP)
                        
            NavigationLink(destination: PrePurchaseView(cartItems: self.$cartItems, cashback: self.$cashback, totalMRP: self.$totalMRP, showSelf: self.$showPrePurchaseView), isActive: self.$showPrePurchaseView) {
                EmptyView()
            }

            Button(action: {
                self.showPrePurchaseView.toggle()
            }) {
                HStack {
                    Text("Proceed").foregroundColor(Color.white)
                    Spacer()
                    Image("arrow.right").foregroundColor(Color.white)
                }.padding(12).background(Color(UIColor.acceptColorGreen)).cornerRadius(4)
            }
        }.padding().background(Color.white)
    }
}
