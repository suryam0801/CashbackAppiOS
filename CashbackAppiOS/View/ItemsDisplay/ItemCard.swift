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
    @State var show  = false
    
    
    var body : some View{
        
        VStack(spacing: 8){
            
            NavigationLink(destination: DetailedItemView(show: self.$show, item: self.item), isActive: $show) {
                Image("p21").renderingMode(.original).resizable().frame(width: UIScreen.main.bounds.width / 2 - 25, height: 240)
            }

            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(item.name)
                    Text("\(item.price)").fontWeight(.heavy)
                }
                Spacer()
                Button(action: {
                    
                }) {
                    
                    Image("option").renderingMode(.original)
                    
                }.padding(.trailing, 15)
            }
        }
    }
}
