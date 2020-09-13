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
                                
                ItemsDisplayMainView()
                
                Spacer()
                
                }.navigationBarTitle("Cashback", displayMode: .inline).navigationBarItems(leading: navBarMenu, trailing: NavBarEndButtons(showCart: self.$showCart))
                .edgesIgnoringSafeArea(.bottom)
        }.onAppear(){
            customer = Helpers.retrieveStoredCustomer()
        }
    }
    
    var navBarMenu : some View {
        Button(action: {
            
        }) {
            Image("Menu").renderingMode(.original)
        }
    }
}
