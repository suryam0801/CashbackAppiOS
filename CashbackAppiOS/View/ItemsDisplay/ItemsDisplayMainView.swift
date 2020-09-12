//
//  ItemsDisplayMainView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct ItemsDisplayMainView : View {
    
    @State var selected = "Dress"
    
    var body : some View{
        
        VStack(spacing: 15){
            
            HStack{
                
                HStack{
                    
                    Button(action: {
                        
                    }) {
                        
                        HStack{
                            
                            Text("Causal Dress")
                            
                            Spacer()
                            
                            Image("down")
                            
                        }.padding()
                        
                    }.foregroundColor(.black)
                    .background(Color.white)
                    
                    
                    Button(action: {
                        
                        
                    }) {
                        
                        Image("filter").renderingMode(.original).padding()
                        
                    }.background(Color.white)
                }
            }
            
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
                        
                        Spacer(minLength: 0)
                        
                    }
                }
            }
            
            ItemsScroll()
            
        }.padding()
        .background(Color("Color"))
        .animation(.spring())
        
    }
}
