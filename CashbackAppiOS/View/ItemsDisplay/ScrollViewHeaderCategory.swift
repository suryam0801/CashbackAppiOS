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
    
    @State var categories:[String] = []
    
    var body: some View {
        VStack {
            if self.categories.isEmpty {
                Indicator()
            } else {
                ScrollView (.horizontal) {
                    HStack{
                        ForEach(categories,id: \.self){ i in
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
                }.listStyle(SidebarListStyle())
            }
        }.frame(height: 60).onAppear(){
            CategoriesViewModel().fetchCategories { (categories) in
                self.categories = categories
            }
        }
    }
}
