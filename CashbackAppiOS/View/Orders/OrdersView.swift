//
//  ViewOrders.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct OrdersView: View {
    @ObservedObject private var ordersViewModel = OrdersViewModel()
    var body: some View {
        VStack {
            if self.ordersViewModel.ordersList.isEmpty {
                Spacer()
                Text("No Orders Yet").font(.system(size: 30))
                Spacer()
                Indicator()
            } else {
                ScrollView (.vertical, showsIndicators: false) {
                    ForEach (self.ordersViewModel.ordersList, id: \.id) { order in
                        OrderCard(order: order)
                    }
                }
                Spacer()
            }
        }.navigationBarTitle("Order History", displayMode:.inline)
        .background(Color("Color"))
        .onAppear(){
            guard SkipChecker().skip == false else {
                SkipChecker().makeUserLogin()
                return
            }
            self.ordersViewModel.fetchOrders()
        }
    }
}
