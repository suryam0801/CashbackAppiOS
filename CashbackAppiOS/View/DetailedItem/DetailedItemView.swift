//
//  DetailedItemView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct DetailedItemView : View {

    var item:Item

    @State var sizes:[String] = [String]()
    @State var size = ""
    @State var selectedSizeSoldOut:Bool = false

    @State var selectedColor = ""
    @State var quantity:Double = 1
    @State var cashback:[Double] = [0,0]
    @State var showCart:Bool = false

    @State var showCheckout:Bool = false
    @State var showPayment:Bool = false
    @State var cartItems:[CartItem] = []
    @State var totalBill:Double = 0

    var body : some View{

        VStack(spacing : 0){

            if self.showCart {
                NavigationLink(destination: CartView(show: self.$showCart), isActive: self.$showCart) {EmptyView()}
            }

            ItemImageDisplay(url: self.item.photos[0], width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)

            if showCheckout {
                EndOfCartPriceDisplayView(cartItems: self.$cartItems, cashback: self.$cashback, totalMRP: self.$totalBill)
            } else {
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
                    .padding(.top, -70)

            }
        }.navigationBarTitle(item.name).navigationBarItems(trailing: NavBarEndButtons(showCart: self.$showCart)).onAppear(){self.onAppearHelper()}
    }

    var itemDetailHeader : some View {
        HStack (alignment: .center) {
            VStack(alignment: .leading, spacing: 8){

                Text(self.item.name).font(.largeTitle)
                Text("\(self.item.price.removeZerosFromEnd())").fontWeight(.heavy)
            }
            Spacer()

            Image("share").resizable().frame(width: 25, height: 30).onTapGesture {
                SharePopup.sharePopup(id: self.item.id, name: self.item.name)
            }
        }
    }

    var sizePicker : some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Size").font(.subheadline)
                if self.selectedSizeSoldOut {
                    Text("(Sorry this size is sold out)").font(.subheadline).foregroundColor(Color(UIColor.rejectButtonRed))
                }
            }
            HStack{
                ForEach(sizes,id: \.self){i in
                    Button(action: {
                        if self.item.stock[i] == 0 {
                            self.selectedSizeSoldOut = true
                        } else {
                            self.selectedSizeSoldOut = false
                        }
                        self.size = i
                    }) {

                        Text(i).padding(10).border(self.selectedSizeSoldOut ? Color.red : Color.black, width: self.size == i ? 1.5 : 0)

                    }.foregroundColor(.black)
                }
            }
        }
    }

    var quantityPicker: some View{
        VStack (alignment: .leading) {
            Stepper(onIncrement: self.increment, onDecrement: self.decrement) {
                Text("Select Quantity: ").font(.subheadline)
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
                guard self.selectedSizeSoldOut == false else {return}
                let cartItem:CartItem = self.makeCartItem()
                DBWriteHelper.addToCart(cartItem: cartItem)
            }) {
                Text("Add To Cart").padding().border(Color.black, width: 1.4)
            }.foregroundColor(.black)

            Spacer()

            Button(action: {
                guard self.selectedSizeSoldOut == false else {return}
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
        self.sizes = self.item.sizes
        self.size = self.sizes[0]
        self.totalBill = self.item.price
        Helpers.cashbackArraySetter(cashback: &cashback, price: self.item.price)
    }
}
