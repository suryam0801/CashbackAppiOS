//
//  ItemsScroll.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemsScroll : View {
    
    @Binding var selectedCategory:String
    @ObservedObject private var itemViewModel = ItemsViewModel()
    @State var cashbackRetrived:Bool = false
    let columns = [
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40)
    ]

    var body : some View{
        
        VStack{
            if self.itemViewModel.itemsList.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(self.itemViewModel.itemsList, id: \.id) { item in
                            if item.category.contains(selectedCategory) {
                                ItemCard(item: item)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }.onAppear(){
            self.onAppearHelper()
        }.onDisappear(){
            self.itemViewModel.cleanup()
        }
    }
    
    func onAppearHelper() {
        self.itemViewModel.fetchItems()
        CashbackAmountViewModel().fetchAmount { (retrieved) in
            if retrieved {
                self.cashbackRetrived = true
            }
        }
    }
    
    var cashbackBanner : some View {
        VStack (alignment: .center) {
            Text("\(cashbackAmount!.amount)₹ won in cashback!").font(.system(size: 25)).foregroundColor(Color.white)
        }.frame(width: UIScreen.main.bounds.width - 35, height: 70).background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.supportTextBlue), .blue]), startPoint: .leading, endPoint: .trailing)).cornerRadius(10)
    }
}
