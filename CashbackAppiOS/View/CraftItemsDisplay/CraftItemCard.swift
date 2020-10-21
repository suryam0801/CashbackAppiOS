//
//  CraftItemCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 20/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CraftItemCard: View {
    var craftItem:CraftItem
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(alignment: .leading, spacing: 8){

                    ItemImageDisplay(url: self.craftItem.photos[0], width: geo.size.width, height: 200)

                    VStack(alignment: .leading, spacing: 5){
                        Text(craftItem.name).font(.system(size: 14)).bold()
                        Text("\(craftItem.price.removeZerosFromEnd())₹").font(.system(size: 14)).bold()
                    }

                }.padding(.top, 20)

                HStack {
                    Spacer()
                    VStack {
                        Text(Helpers.cashbackDisplayText(item: self.craftItem))
                            .font(.system(size: 15))
                            .foregroundColor(Color.white)
                            .padding(7)
                            .background(Color(UIColor.acceptColorGreen))
                            .cornerRadius(5)
                        Spacer()
                    }
                }
            }
        }.padding().shadow(radius: 5)
    }
}
