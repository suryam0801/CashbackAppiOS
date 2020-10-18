//
//  PrePurchaseView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 28/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct PrePurchaseView: View {
    
    @Binding var cartItems:[CartItem]
    @Binding var cashback:[Double]
    @Binding var totalMRP:Double
    @State private var showPayment:Bool = false
    @State private var showCashbackPicker:Bool = false
    @State private var promoCodeEntry:String = ""
    
    @State private var showAddressChooser:Bool = false
    @State private var address:String = ""
    
    @Binding var showSelf:Bool
    
    var body: some View {
        VStack {
            if !showCashbackPicker {
                self.CheckoutView
            } else if (self.showCashbackPicker) {
                CashbackPickerView()
            }
        }.sheet(isPresented: self.$showAddressChooser, content: {
            AddressView(showAddressPicker: self.$showAddressChooser, address: self.$address)
        }).onAppear(){
            self.onAppearHelper()
        }.padding()
    }
    
    var CheckoutView : some View {
        VStack {
            
            Text("Promo Code").font(Font.system(size:25).weight(.bold)).fontWeight(.heavy).padding(.top, 30)
            
            Text("Please enter a valid promo code to get 50% more cashback")
                .font(Font.system(size:13))
                .foregroundColor(.gray)
                .padding(.top, 12)
            
            TextField("Enter Promo Code", text: self.$promoCodeEntry)
                .padding()
                .background(retrievedPromoCodes!.keys.contains(self.promoCodeEntry.lowercased()) ? Color(UIColor.acceptColorGreen).opacity(0.5) : Color(UIColor.textFieldLightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
            if !self.showAddressChooser {
                HStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Shipping Address")
                                .font(Font.system(size:13))
                                .foregroundColor(.gray)
                                .padding(.top, 12)
                            Image("pencil").onTapGesture(count: 1, perform: {
                                self.showAddressChooser = true
                            })
                        }
                        VStack {
                            Text("\(customer?.address ?? "")").lineLimit(nil)
                        }
                    }
                    Spacer()
                }.padding()
                .background(Color(UIColor.textFieldLightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Spacer()

            BillSummaryView(cartItems: self.$cartItems, cashback: self.$cashback, totalMRP: self.$totalMRP)
            
            NavigationLink(destination: RazorPayDisplay(cartItems: self.cartItems), isActive: self.$showPayment) {
                EmptyView()
            }
            
            Button(action: {
                promoCode = self.promoCodeEntry
                tempCartTotal = self.totalMRP
                self.showPayment.toggle()
            }) {
                HStack {
                    Text("Checkout").foregroundColor(Color.white)
                    Spacer()
                    Image("arrow.right").foregroundColor(Color.white)
                }.padding(12).background(Color(UIColor.acceptColorGreen)).cornerRadius(4)
            }
        }
    }

    func onAppearHelper () {
        if transactionId != nil {
            self.showPayment = false
            self.showCashbackPicker = true
        }
        if customer?.address == nil {
            self.showAddressChooser = true
        } else {
            self.address = customer?.address! as! String
        }
    }
}
