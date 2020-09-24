//
//  ItemsDisplayMainView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemsDisplayMainView : View {
    
    @State var selected = "All"
    
    var body : some View{
        
        VStack(spacing: 15){
            
            ScrollViewHeaderCategory(selected: self.$selected)
                        
            ItemsScroll(selectedCategory: self.$selected)
            
        }.padding()
        .background(Color("Color"))
        .animation(.spring())
        
    }
}
