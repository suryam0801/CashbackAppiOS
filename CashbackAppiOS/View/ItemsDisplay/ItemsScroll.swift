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
    @ObservedObject private var itemViewModel = ItemsViewModel()
    
    var body : some View{
        
        VStack{
            if self.itemViewModel.itemGrid.isEmpty {
                Indicator()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12){
                        
                        ForEach(self.itemViewModel.itemGrid){i in
                            
                            HStack{
                                
                                ForEach(i!.rows!){j in
                                    
                                    ItemCard(item: j)
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(){
            self.itemViewModel.fetchItems()
        }
    }
}
