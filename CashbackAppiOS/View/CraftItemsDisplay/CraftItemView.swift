//
//  CraftItemView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 20/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CraftItemView: View {
    @ObservedObject private var cartItemViewModel = CraftItemViewModel()
    var body: some View {
        VStack {
            if cartItemViewModel.craftItemsList.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(self.cartItemViewModel.craftItemsList, id: \.id) { craftItem in
                            NavigationLink(destination: DetailedCraftItem(craftItem: craftItem)) {
                                CraftItemCard(craftItem: craftItem)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }.onAppear(){
            self.cartItemViewModel.fetchItems()
        }
    }
}
