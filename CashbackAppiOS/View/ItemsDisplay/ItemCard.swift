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
        
        ZStack {
            VStack(alignment: .leading, spacing: 8){
                
                NavigationLink(destination: DetailedItemView(item: self.item)) {
                    ItemImageDisplay(url: self.item.photos[0], width: UIScreen.main.bounds.width / 2 - 25, height: 240)
                }.buttonStyle(PlainButtonStyle())
                
                VStack(alignment: .leading, spacing: 5){
                    Text(item.name).font(.system(size: 14)).bold()
                    Text("\(item.price.removeZerosFromEnd())₹").font(.system(size: 14)).bold()
                }
            }.padding(.top, 20)
            
            HStack {
                Spacer()
                VStack {
                    Text(Helpers.cashbackDisplayText(item: self.item))
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                        .padding(7)
                        .background(Color(UIColor.acceptColorGreen))
                        .cornerRadius(5)
                    Spacer()
                }
            }
        }
    }
}
