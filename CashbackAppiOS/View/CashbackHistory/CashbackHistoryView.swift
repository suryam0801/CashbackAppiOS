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
    @State private var previousTransactionId:String = "wef"
    
    var body: some View {
        VStack {
            if self.cashbackHistoryViewModel.ordersList.isEmpty {
                Indicator()
            } else {
                ForEach (self.cashbackHistoryViewModel.ordersList, id: \.transactionId) { order in
                    Text("\(order.cashback)").onAppear(){self.previousTransactionId = order.transactionId}
                }
            }
        }.onAppear(){
            self.cashbackHistoryViewModel.fetchOrdersForCashback()
        }.onDisappear() {
            self.cashbackHistoryViewModel.cleanup()
        }
    }
}
