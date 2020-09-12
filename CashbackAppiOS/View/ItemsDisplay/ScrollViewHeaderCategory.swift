//
//  ScrollViewHeaderCategory.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ScrollViewHeaderCategory: View {
    @Binding var selected:String
    
    var body: some View {
        HStack{
            ForEach(types,id: \.self){ i in
                
                HStack{
                    
                    Button(action: {
                        
                        self.selected = i
                        
                    }) {
                        
                        Text(i).padding()
                    }
                    .foregroundColor(self.selected == i ? .white : .black)
                    .background(self.selected == i ? Color.black : Color.clear)
                    .cornerRadius(10)
                }
            }
        }
    }
}
