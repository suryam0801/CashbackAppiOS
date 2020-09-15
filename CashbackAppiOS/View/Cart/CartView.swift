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
        }.sheet(isPresented: self.$showCashbackPicker, content: {
            CashbackPickerView()
        }).background(Color("Color"))
            .navigationBarTitle("My Cart", displayMode: .inline)
            .onAppear(){self.onAppearHelper()}
            .onDisappear(){self.cartList.cleanup()}
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
    
    func calculateTotalMRP () {
        for item in self.cartList.inCartList {
            self.totalMRP += (item.price * item.quantity)
            
            if item.price <= 500 {
                self.totalCashBack[0] += (50 * item.quantity)
                self.totalCashBack[1] += (150 * item.quantity)
            } else {
                self.totalCashBack[0] += (100 * item.quantity)
                self.totalCashBack[1] += (200 * item.quantity)
            }
        }
    }
}
