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
    @State var quantity:Int = 0
    @Binding var mrp:Int
    @Binding var cashback:[Int]
    
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
                    Text("\(cartItem.price)₹").font(.subheadline).foregroundColor(Color.gray)
                    Spacer().frame(height: 10)
                    Text("Color: \(cartItem.color)").font(.subheadline)
                    Spacer().frame(height: 10)
                    Text(cartItem.price <= 500 ? "50 - 150₹ cashback!" : "100 - 250₹ cashback!")
                        .foregroundColor(Color(UIColor.acceptColorGreen)).font(.subheadline)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(UIColor.acceptColorGreen), lineWidth: 2))
                    
                    Spacer().frame(height: 10)
                    Stepper(onIncrement: self.increment, onDecrement: self.decrement) {
                        Text("Qty: \(self.quantity)").font(.subheadline)
                    }
                    Spacer()
                }

                Spacer()
            }.padding(.top, 10)
            
            Divider().padding([.top,.leading,.trailing], 10)
            
            Button (action: {
                DBWriteHelper.removeFromCart(cartItem: self.cartItem)
            }) {
                HStack{
                    Image("trash").resizable().frame(width: 13, height: 15).foregroundColor(Color(UIColor.rejectButtonRed))
                    Text("REMOVE").font(.system(size: 13)).foregroundColor(Color(UIColor.rejectButtonRed))
                }
            }.padding(.bottom, 10)
            
        }.background(Color.white).onAppear(){self.quantity = self.cartItem.quantity}
    }
    
    private func increment () {

        func updateMRP () {
            self.mrp += self.cartItem.price
            self.cashback[0] += self.cartItem.price <= 500 ? 50 : 100
            self.cashback[1] += self.cartItem.price <= 500 ? 150 : 250
        }
        
        if self.quantity != 10 {
            self.quantity += 1
            updateMRP()
            DBWriteHelper.updateItemQuantity(cartItemId: self.cartItem.itemId, newQuantity: self.quantity)
        }
    }
    
    private func decrement () {
        
        func updateMRP () {
            self.mrp -= self.cartItem.price
            self.cashback[0] -= self.cartItem.price <= 500 ? 50 : 100
            self.cashback[1] -= self.cartItem.price <= 500 ? 150 : 250
        }
        
        if self.quantity != 1 {
            self.quantity -= 1
            updateMRP()
            DBWriteHelper.updateItemQuantity(cartItemId: self.cartItem.itemId, newQuantity: self.quantity)
        }
    }
}
