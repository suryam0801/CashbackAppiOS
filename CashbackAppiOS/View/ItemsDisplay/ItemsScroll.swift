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
    
    var body : some View{

        VStack{
            if self.itemViewModel.itemGrid.isEmpty {
                Indicator()
            } else {
                ScrollView(.vertical, showsIndicators: false) {

                    VStack(spacing: 12){

                        if self.cashbackRetrived {
                            cashbackBanner
                        }

                        ForEach(self.itemViewModel.itemGrid){i in
                            HStack{
                                ForEach(i.rows!){j in
                                    if j.category.contains(self.selectedCategory) {
                                        ItemCard(item: j)
                                    }
                                }
                            }
                        }
                    }
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
