//
//  ItemsScroll.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemsScroll : View {
    
    @State var show = false
    @Binding var selectedCategory:String
    @ObservedObject private var itemViewModel = ItemsViewModel()
    
    @State var showCashbackPicker:Bool = false
    
    var body : some View{
        
        VStack{
            if self.itemViewModel.itemGrid.isEmpty {
                Indicator()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12){
                        cashbackBanner
                        
                        ForEach(self.itemViewModel.itemGrid){i in
                            HStack{
                                ForEach(i!.rows!){j in
                                    if j.category.contains(self.selectedCategory) {
                                        ItemCard(item: j)
                                    } 
                                }
                            }
                        }
                    }
                }.sheet(isPresented: self.$showCashbackPicker, content: {
                    CashbackPickerView()
                })
            }
        }.onAppear(){
            self.onAppearHelper()
        }.onDisappear(){
            self.itemViewModel.cleanup()
        }
    }
    
    func onAppearHelper() {
        if transactionId == nil {
            self.itemViewModel.fetchItems()
        } else {
            self.showCashbackPicker = true
            transactionId = nil
        }
    }
    
    var cashbackBanner : some View {
        VStack (alignment: .center) {
            Text("1,54,801₹ won in cashback!").font(.system(size: 25)).foregroundColor(Color.white)
            }.frame(width: UIScreen.main.bounds.width - 35, height: 70).background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.supportTextBlue), .blue]), startPoint: .leading, endPoint: .trailing)).cornerRadius(10)
    }
}
