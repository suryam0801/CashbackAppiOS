//
//  DetailedCraftItem.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 20/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import Combine

struct DetailedCraftItem: View {
    var craftItem:CraftItem
    
    @State var quantity:Double = 1
    @State var cashback:[Double] = [0,0]
    @State var showCart:Bool = false
    
    @State var selectedOptions:[String] = [String](repeating: "", count: 10)
    @State var enteredText:[String] = [String](repeating: "", count: 10)
    @State var maxCharacters:Int = 0
    
    @State var showCheckout:Bool = false
    @State var showPayment:Bool = false
    @State var cartItems:[CartItem] = []
    @State var totalBill:Double = 0
    
    @State var showAddedAlertPopup:Bool = false
    
    var body : some View {

        return VStack(spacing : 0){
            
            if self.showCart {
                NavigationLink(destination: CartView(), isActive: self.$showCart) {EmptyView()}
            }
            
            ImageCarouselView(numberOfImages: 3) {
                ItemImageDisplay(url: self.craftItem.photos[0], width: UIScreen.main.bounds.width, height: 200)
                ItemImageDisplay(url: self.craftItem.photos[1], width: UIScreen.main.bounds.width, height: 200)
                ItemImageDisplay(url: self.craftItem.photos[2], width: UIScreen.main.bounds.width, height: 200)
            }.shadow(radius: 5).frame(height: 200)
            
            if showCheckout {
                EndOfCartPriceDisplayView(cartItems: self.$cartItems, cashback: self.$cashback, totalMRP: self.$totalBill)
            } else {
                ScrollView {
                    VStack(alignment: .leading ,spacing: 15) {

                        itemDetailHeader

                        Text("\(self.cashback[0].removeZerosFromEnd()) to \(self.cashback[1].removeZerosFromEnd())₹ Cashback!!!")
                            .font(.system(size: 20))
                            .bold()
                            .padding()
                            .background(Color(UIColor.acceptColorGreen))
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                            .fixedSize(horizontal: false, vertical: true)

                        if self.craftItem.options != nil {
                            ForEach(craftItem.options.keys.sorted(by: >), id: \.self) { key in
                                VStack (alignment: .leading) {
                                    Text(key).foregroundColor(Color.black).lineLimit(nil)
                                    ChipsContent(title: key,
                                        chipsData: craftItem.options[key]!,
                                        selectedChip: self.$selectedOptions[Array(craftItem.options.keys).firstIndex(of: key)!],
                                        maxCharacters: self.$maxCharacters)
                                }
                            }
                        }

                        if self.craftItem.TextEntry != nil {
                            ForEach(craftItem.TextEntry.keys.sorted(by: >), id: \.self) { entry in
                                Text("Please enter \(entry) below").foregroundColor(Color.black).lineLimit(nil)
                                TextField("",
                                          text: $enteredText[Array(craftItem.TextEntry.keys).firstIndex(of: entry)!])
                                    .padding()
                                    .background(Color(UIColor.textFieldLightGrey))
                                    .cornerRadius(5)
                                    .onReceive(Just(enteredText[Array(craftItem.TextEntry.keys).firstIndex(of: entry)!])) { inputValue in
                                        if inputValue.count > maxCharacters {
                                            self.enteredText[Array(craftItem.TextEntry.keys).firstIndex(of: entry)!].removeLast()
                                        }
                                    }
                            }
                        }
                        
                        if self.craftItem.photoNeeded {
                            Text("As we need photos for this product, we will message you to gather them once your order has been placed :)")
                        }

                        checkOutHelper

                    }.padding([.leading, .trailing])
                }
            }
            
            Spacer()
            
        }
        .alert(isPresented: $showAddedAlertPopup) {
            Alert(title: Text("Added to cart"), message: Text("\(self.craftItem.name) has been added to your cart. Enjoying continuing shopping"), dismissButton: .default(Text("Got it!")))
        }
        .navigationBarTitle(craftItem.name)
        .navigationBarItems(trailing: NavBarEndButtons())
        .onAppear(){self.onAppearHelper()}
    }
    
    var itemDetailHeader : some View {
        HStack (alignment: .center) {
            VStack(alignment: .leading, spacing: 8){
                
                Text(self.craftItem.name).font(.largeTitle)
                Text("\(self.craftItem.price.removeZerosFromEnd())₹").fontWeight(.heavy)
            }
            Spacer()
            
            Image("share").resizable().frame(width: 25, height: 30).onTapGesture {
                SharePopup.sharePopup(id: self.craftItem.id, name: self.craftItem.name)
            }
        }
    }
    
    var checkOutHelper : some View  {
        HStack{
            Button(action: {
                let cartItem:CartItem = self.makeCartItem()
                self.showAddedAlertPopup.toggle()
                DBWriteHelper().addToCart(cartItem: cartItem)
            }) {
                Text("Add To Cart").padding().border(Color.black, width: 1.4)
            }.foregroundColor(.black)

            Spacer()

            Button(action: {
                self.selectedOptions = self.selectedOptions.filter({ $0 != ""})
                self.enteredText = self.enteredText.filter({ $0 != ""})
                self.showCheckout.toggle()
                self.cartItems.append(self.makeCartItem())
                DBWriteHelper().addToCart(cartItem: self.cartItems[0])
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
        return CartItem(itemId: self.craftItem.id, name: self.craftItem.name, price: self.craftItem.price, maxCashback: self.craftItem.maxCashback, minCashback: self.craftItem.minCashback, photos: self.craftItem.photos, storeIds: self.craftItem.storeIds, color: "NA", size: "NA", quantity: 1, photoNeeded: craftItem.photoNeeded, options: self.selectedOptions, TextEntry: self.enteredText)
    }
    
    func onAppearHelper () {
        self.totalBill = self.craftItem.price
        Helpers.cashbackArraySetter(cashback: &cashback, item: self.craftItem)
    }
}
