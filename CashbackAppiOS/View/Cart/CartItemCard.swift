//
//  CartItemDisplay.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CartItemCard: View {
    var cartItem : CartItem
    @State var quantity:Double = 1
    @Binding var mrp:Double
    @Binding var cashback:[Double]
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 10)
                
                VStack {
                    Image("p11").resizable().frame(width: 130, height: 165)
                    Spacer()
                }
                
                VStack (alignment: .leading) {
                    Text(cartItem.name).bold().font(.headline)
                    Text("\(cartItem.price.removeZerosFromEnd())₹").font(.subheadline).foregroundColor(Color.gray)
                    Spacer().frame(height: 10)
                    Text("Color: \(cartItem.color)").font(.subheadline)
                    Text("Size: \(cartItem.size)").font(.subheadline)
                    Spacer().frame(height: 10)
 
                    Text(cartItem.price <= 500 ? "50 - 150₹ cashback!" : "100 - 250₹ cashback!")
                        .foregroundColor(Color(UIColor.acceptColorGreen)).font(.subheadline)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(UIColor.acceptColorGreen), lineWidth: 2))

                    Spacer().frame(height: 10)
                    Stepper(onIncrement: self.increment, onDecrement: self.decrement) {
                        Text("Qty: \(self.quantity.removeZerosFromEnd())").font(.subheadline)
                    }
                    Spacer()
                }

                Spacer()
            }.padding(.top, 10)
            
            Divider().padding([.top,.leading,.trailing], 10)
            
            Button (action: {
                DBWriteHelper.removeFromCart(cartItemId: self.cartItem.itemId)
            }) {
                HStack{
                    Image("trash").resizable().frame(width: 13, height: 15).foregroundColor(Color(UIColor.rejectButtonRed))
                    Text("REMOVE").font(.system(size: 13)).foregroundColor(Color(UIColor.rejectButtonRed))
                }
            }.padding(.bottom, 10)
            
        }.background(Color.white).onAppear(){self.quantity = self.cartItem.quantity}
    }
    
    private func increment () {
        Helpers.quantityIncrement(quantity: &self.quantity, cartItemPrice: self.cartItem.price, currentMRP: &self.mrp, cashback: &self.cashback)
        DBWriteHelper.updateItemQuantity(cartItemId: self.cartItem.itemId, newQuantity: self.quantity)
    }

    private func decrement () {
        Helpers.quantityDecrement(quantity: &self.quantity, cartItemPrice: self.cartItem.price, currentMRP: &self.mrp, cashback: &self.cashback)
        DBWriteHelper.updateItemQuantity(cartItemId: self.cartItem.itemId, newQuantity: self.quantity)
    }
}
