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
    @State var quantity = 1
    @State var showCart:Bool = false
    
    var body : some View{
        
        NavigationView {
            
            if self.showCart {
                NavigationLink(destination: CartView(show: self.$showCart), isActive: self.$showCart) {EmptyView()}
            }
            
            VStack(spacing : 0){
                
                customNavBar
                
                Image("pic").resizable()
                
                VStack(alignment: .leading ,spacing: 15){
                    itemDetailHeader
                    Text("Fitted top made from a polyamide blend. Features wide straps and chest reinforcement.")
                    sizePicker
                    checkOutHelper
                }.padding()
                    .background(RoundedBG().fill(Color.white))
                    .padding(.top, -50)
                
            }
        }.navigationBarTitle("").navigationBarHidden(true)
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
                Text("\(self.item.price)").fontWeight(.heavy)
            }
            
            Spacer()
            
            HStack(spacing: 10){
                
                Circle().fill(Color.green).frame(width: 20, height: 20)
                Circle().fill(Color.blue).frame(width: 20, height: 20)
                Circle().fill(Color.red).frame(width: 20, height: 20)
            }
        }
        
    }
    
    var sizePicker : some View {
        VStack {
            Text("Select Size")
            
            HStack{
                
                ForEach(sizes,id: \.self){i in
                    
                    Button(action: {
                        
                        self.size = i
                        
                    }) {
                        
                        Text(i).padding().border(Color.black, width: self.size == i ? 1.5 : 0)
                        
                    }.foregroundColor(.black)
                }
            }
        }
    }
    
    var checkOutHelper : some View  {
        HStack{
            
            Button(action: {
                
                let cartItem:CartItem = CartItem(itemId: self.item.id, name: self.item.name, price: self.item.price, photos: self.item.photos, storeIds: self.item.storeIds, color: self.selectedColor, size: self.size, quantity: self.quantity)

                DBWriteHelper.addToCart(cartItem: cartItem)
            }) {
                
                Text("Add To Cart").padding().border(Color.black, width: 1.4)
                
            }.foregroundColor(.black)
            
            Spacer()
            
            Button(action: {
                
            }) {
                
                Text("Buy Now").padding()
                
            }.foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
            
        }.padding([.leading,.trailing], 15)
            .padding(.top, 15)
    }
}
