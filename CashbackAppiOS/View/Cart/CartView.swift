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

    @State var totalMRP:Double = 0
    @State var totalCashBack:[Double] = [0,0]

    @State var showCashbackPicker:Bool = false

    var body: some View {
        VStack {
            if cartList.inCartList.isEmpty {
                Indicator()
            } else {
                ScrollView (.vertical, showsIndicators: false) {
                    ForEach (self.cartList.inCartList, id: \.itemId) { cartItem in
                        CartItemCard(cartItem: cartItem, mrp: self.$totalMRP, cashback: self.$totalCashBack)
                    }
                    
                    EndOfCartPriceDisplayView(cartItems: self.$cartList.inCartList, cashback: self.$totalCashBack, totalMRP: self.$totalMRP)
                    
                }.onAppear(){self.calculateTotalMRP()}.padding(.top, 10)
            }
        }.background(Color("Color"))
            .navigationBarTitle("My Cart", displayMode: .inline)
            .onAppear(){self.onAppearHelper()}
            .onDisappear(){self.onDisappearHelper()}
    }
    
    func onAppearHelper() {
        if transactionId == nil {
            self.cartList.fetchItems()
        } else {
            self.cartList.inCartList.removeAll()
            self.showCashbackPicker = true
            transactionId = nil
        }
    }
    
    func onDisappearHelper () {
        self.cartList.cleanup()
        self.totalMRP = 0
        self.totalCashBack = [0,0]
    }

    func calculateTotalMRP () {
        for item in self.cartList.inCartList {
            self.totalMRP += (item.price * item.quantity)
            Helpers.totalCashbackCalculator(cashback: &self.totalCashBack, price: item.price, itemQuantity: item.quantity)
        }
    }
}
