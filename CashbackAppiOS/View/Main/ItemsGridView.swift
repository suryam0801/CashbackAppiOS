//
//  ItemsGridView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemsGridView: View {
    @ObservedObject private var itemViewModel = ItemsViewModel()
    
    var body: some View {
        VStack {
            List(self.itemViewModel.itemsList) { item in
                Text(item.name)
            }
        }.onAppear(){
            self.itemViewModel.fetchItems()
        }
    }
}

struct ItemsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsGridView()
    }
}
