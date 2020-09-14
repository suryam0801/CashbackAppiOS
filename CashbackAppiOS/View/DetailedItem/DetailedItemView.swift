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
    
    @State var showPayment:Bool = false
    @State var paymentRecieved:Bool = false
    @State var cartItems:[CartItem] = []
    
    var body : some View{
        
        NavigationView {

            if self.showCart {
                NavigationLink(destination: CartView(show: self.$showCart), isActive: self.$showCart) {EmptyView()}
            }
            
            if self.showPayment && !self.paymentRecieved {
                NavigationLink(destination: RazorPayDisplay(showSelf: self.$paymentRecieved, cartItems: self.cartItems, cashback: self.cashback), isActive: self.$showPayment) {
                    EmptyView()
                }
            }


            VStack(spacing : 0){
                
                customNavBar
                
                Image("pic").resizable()
                
                VStack(alignment: .leading ,spacing: 15){
                    itemDetailHeader
                    Text("This item has a cashback value anywhere between \(self.cashback[0].removeZerosFromEnd()) to \(self.cashback[1].removeZerosFromEnd())").fixedSize(horizontal: false, vertical: true)
                    sizePicker
                    quantityPicker
                    checkOutHelper
                }.padding()
                    .background(RoundedBG().fill(Color.white))
                    .padding(.top, -50)
                
            }
        }.navigationBarTitle("").navigationBarHidden(true).onAppear(){self.cashbackInit()}
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
            Text("Select Quantity").font(.subheadline)
            Stepper("\(self.quantity.removeZerosFromEnd())", value: self.$quantity, in: 1...10)
        }
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
                
                self.cartItems.append(self.makeCartItem())
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
    
    func cashbackInit () {
        self.cashback[0] = self.item.price <= 500 ? 50 : 100
        self.cashback[1] = self.item.price <= 500 ? 150 : 250
    }
}
