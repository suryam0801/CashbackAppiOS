//
//  ItemCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemCard : View {
    
    var row : row
    @State var show  = false
    
    
    var body : some View{
        
        VStack(spacing: 8){
            
            NavigationLink(destination: DetailedItemView(show: $show), isActive: $show) {
                
                Image(row.image).renderingMode(.original).resizable().frame(width: UIScreen.main.bounds.width / 2 - 25, height: 240)
            }
            
           
            
            HStack{
                
                VStack(alignment: .leading, spacing: 10){
                    
                    Text(row.name)
                    Text(row.price).fontWeight(.heavy)
                    
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
