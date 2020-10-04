//
//  CashbackHistoryView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CashbackHistoryView: View {
    
    @ObservedObject private var cashbackHistoryViewModel = OrdersViewModel()
    
    var body: some View {
        VStack (spacing: 0) {
            if self.cashbackHistoryViewModel.ordersList.isEmpty {
                Indicator()
            } else {
                
                ScrollView {
                    
                    Spacer().frame(height: 10)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Total Earned: \(Helpers.totalCashbackAmount(orderList: self.cashbackHistoryViewModel.ordersList).removeZerosFromEnd())₹").font(.largeTitle).foregroundColor(Color.white)
                        }.padding(10)
                        Spacer()
                    }.background(Color(UIColor.acceptColorGreen)).cornerRadius(4).padding([.leading, .trailing], 10)

                    Spacer().frame(height: 10)
                    
                    ForEach (self.cashbackHistoryViewModel.ordersList, id: \.id) { order in
                        CashbackHistoryCard(order: order)
                    }
                }
            }
            Spacer()
        }.navigationBarTitle("Cashback History", displayMode: .inline).onAppear(){
            self.cashbackHistoryViewModel.fetchOrdersForCashback()
        }.onDisappear() {
            self.cashbackHistoryViewModel.cleanup()
        }
    }
}
