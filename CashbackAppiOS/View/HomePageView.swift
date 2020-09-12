//
//  ItemsGridView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView{
         
            VStack(spacing: 15){
                
                ZStack{
                    
                    Text("Seasons").font(.title)
                    
                    HStack(spacing: 18){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("Menu").renderingMode(.original)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("search").renderingMode(.original)
                        }
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("noti").renderingMode(.original)
                        }
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("shop").renderingMode(.original)
                        }

                    }
                }.background(Color.white)
                .padding([.leading,.trailing,.top], 15)
                
                ItemsDisplayMainView()
            }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
    }
}
