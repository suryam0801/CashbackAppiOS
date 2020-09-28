//
//  ItemCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemCard : View {
    
    var item : Item
    
    var body : some View{
        
        HStack {
            VStack(alignment: .leading, spacing: 8){
                
                NavigationLink(destination: DetailedItemView(item: self.item)) {
                    ItemImageDisplay(url: self.item.photos[0], width: UIScreen.main.bounds.width / 2 - 25, height: 240)
                }.buttonStyle(PlainButtonStyle())

                HStack{
                    VStack(spacing: 5){
                        Text(item.name)
                        Text("\(item.price.removeZerosFromEnd())₹").fontWeight(.heavy)
                    }
                }
            }
            Spacer()
        }
    }
}
