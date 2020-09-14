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
                Indicator()
            } else {
                ScrollView (.vertical, showsIndicators: false) {
                    ForEach (self.ordersViewModel.ordersList, id: \.id) { order in
                        Text("\(order.id)")
                    }
                }
            }
        }.background(Color("Color")).onAppear(){self.ordersViewModel.fetchOrders()}
    }
}
