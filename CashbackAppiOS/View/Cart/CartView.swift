//
//  CartView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartList:CartViewModel = CartViewModel()
    @Binding var show : Bool
    
    var body: some View {
        VStack {
            if cartList.inCartList.isEmpty {
                Indicator()
            } else {
                ScrollView (.vertical, showsIndicators: false) {
                    ForEach (self.cartList.inCartList, id: \.itemId) { cartItem in
                        CartItemCard(cartItem: cartItem)
                    }
                }.padding(.top, 10)
            }
        }.background(Color("Color"))
            .navigationBarTitle("My Cart", displayMode: .inline)
            .onAppear(){self.cartList.fetchItems()}
            .onDisappear(){self.cartList.cleanup()}
    }
}
