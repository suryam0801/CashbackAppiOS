//
//  DetailedItemView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct DetailedItemView : View {
    
    @Binding var show : Bool
    var item:Item
    @State var size = "M"
    @State var selectedColor = ""
    @State var quantity:Double = 1
    @State var cashback:[Double] = [0,0]
    @State var showCart:Bool = false
    
    @State var showCheckout:Bool = false
    @State var showPayment:Bool = false
    @State var paymentRecieved:Bool = false
    @State var cartItems:[CartItem] = []
    @State var totalBill:Double = 0
    
    var body : some View{
        
        NavigationView {

            if self.showCart {
                NavigationLink(destination: CartView(show: self.$showCart), isActive: self.$showCart) {EmptyView()}
            }
        
            VStack(spacing : 0){
                
                customNavBar
                
                Image("pic").resizable()
                
                VStack(alignment: .leading ,spacing: 15){
                    
                    if !self.showCheckout {
                        itemDetailHeader
                        Text("This item has a cashback value anywhere between \(self.cashback[0].removeZerosFromEnd()) to \(self.cashback[1].removeZerosFromEnd())").fixedSize(horizontal: false, vertical: true)
                        sizePicker
                        quantityPicker
                        checkOutHelper
                    } else {
                        CartItemCard(cartItem: self.cartItems[0], mrp: self.$totalBill, cashback: self.$cashback)
                    }
                    
                }.padding()
                    .background(RoundedBG().fill(Color.white))
                    .padding(.top, -50)
                
                if showCheckout {
                    EndOfCartPriceDisplayView(cartItems: self.$cartItems, cashback: self.$cashback, totalMRP: self.$totalBill)
                }
                
            }
        }.navigationBarTitle("").navigationBarHidden(true).onAppear(){self.onAppearHelper()}
    }
    
    var customNavBar : some View {
        HStack(spacing: 18){
            
            Button(action: {
                
                self.show.toggle()
                
            }) {
                
                Image("Back").renderingMode(.original)
            }
            
            Spacer()
            
            NavBarEndButtons(showCart: self.$showCart)
            
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .padding(15)
        
    }
    
    var itemDetailHeader : some View {
        HStack{
            VStack(alignment: .leading, spacing: 8){
                
                Text(self.item.name).font(.largeTitle)
                Text("\(self.item.price.removeZerosFromEnd())").fontWeight(.heavy)
            }
            Spacer()
        }
        
    }
    
    var sizePicker : some View {
        VStack (alignment: .leading) {
            Text("Size").font(.subheadline)
            HStack{
                ForEach(sizes,id: \.self){i in
                    Button(action: {
                        self.size = i
                    }) {
                        
                        Text(i).padding(10).border(Color.black, width: self.size == i ? 1.5 : 0)
                        
                    }.foregroundColor(.black)
                }
            }
        }
    }
    
    var quantityPicker: some View{
        VStack (alignment: .leading) {
            Stepper(onIncrement: self.increment, onDecrement: self.decrement) {
                Text("Select Quantity").font(.subheadline)
                Text("\(self.quantity.removeZerosFromEnd())")
            }
        }
    }
    
    private func increment () {
        Helpers.quantityIncrement(quantity: &self.quantity, cartItemPrice: self.item.price, currentMRP: &self.totalBill, cashback: &self.cashback)
    }
    
    private func decrement () {
        Helpers.quantityDecrement(quantity: &self.quantity, cartItemPrice: self.item.price, currentMRP: &self.totalBill, cashback: &self.cashback)
    }

    var checkOutHelper : some View  {
        HStack{
            
            Button(action: {
                
                let cartItem:CartItem = self.makeCartItem()

                DBWriteHelper.addToCart(cartItem: cartItem)
            }) {
                
                Text("Add To Cart").padding().border(Color.black, width: 1.4)
                
            }.foregroundColor(.black)
            
            Spacer()
            
            Button(action: {

                self.showCheckout.toggle()
                self.cartItems.append(self.makeCartItem())
                DBWriteHelper.addToCart(cartItem: self.cartItems[0])
                self.showPayment.toggle()

            }) {
                
                Text("Buy Now").padding()
                
            }.foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
            
        }.padding([.leading,.trailing], 15)
            .padding(.top, 15)
    }
    
    func makeCartItem () -> CartItem {
        return CartItem(itemId: self.item.id, name: self.item.name, price: self.item.price, photos: self.item.photos, storeIds: self.item.storeIds, color: self.selectedColor, size: self.size, quantity: self.quantity)
    }
    
    func onAppearHelper () {
        self.totalBill = self.item.price
        self.cashback[0] = self.item.price <= 500 ? 50 : 100
        self.cashback[1] = self.item.price <= 500 ? 150 : 250
    }
}
