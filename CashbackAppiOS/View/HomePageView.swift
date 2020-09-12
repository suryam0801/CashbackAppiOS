//
//  ItemsGridView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct HomePageView: View {
    
    @State var showCart = false
    
    var body: some View {
        
        NavigationView{
            
            if self.showCart {
                NavigationLink(destination: CartView(show: self.$showCart), isActive: self.$showCart) {EmptyView()}
            }
            
            VStack(spacing: 15){
                
                NavBar
                
                ItemsDisplayMainView()
                
                Spacer()
                
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.bottom)
        }.onAppear(){
            customer = Helpers.retrieveStoredCustomer()
        }
    }
    
    var NavBar : some View {
        ZStack{
            
            Text("Cashback").font(.title)
            
            HStack(spacing: 18){
                
                Button(action: {
                    
                }) {
                    
                    Image("Menu").renderingMode(.original)
                }

                Spacer()

                NavBarEndButtons(showCart: self.$showCart)
            }
        }.background(Color.white)
            .padding([.leading,.trailing,.top], 15)
    }
}
