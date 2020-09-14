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
    @State var showMenu = false
    @State var viewOrders = false
    @State var cashbackHistory = false
    
    var body: some View {
        
        let drag = DragGesture().onEnded {
            if $0.translation.width < -100 {
                withAnimation {
                    self.showMenu = false
                }
            }
            if $0.translation.width > 100 {
                withAnimation {
                    self.showMenu = true
                }
            }
        }
        
        return GeometryReader { geometry in
            
            ZStack (alignment: .leading) {
                NavigationView{
                    
                    if self.showCart {
                        NavigationLink(destination: CartView(show: self.$showCart), isActive: self.$showCart) {EmptyView()}
                    }
                    
                    if self.viewOrders {
                        NavigationLink(destination: OrdersView(), isActive: self.$viewOrders) {EmptyView()}
                    }
                    
                    if self.cashbackHistory {
                        NavigationLink(destination: CashbackHistoryView(), isActive: self.$cashbackHistory) {EmptyView()}
                    }
                    
                    VStack(spacing: 15){
                        
                        ItemsDisplayMainView()
                        
                        Spacer()
                        
                    }.navigationBarTitle("Cashback", displayMode: .inline).navigationBarItems(leading: self.navBarMenu, trailing: NavBarEndButtons(showCart: self.$showCart))
                        .edgesIgnoringSafeArea(.bottom)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                
                if self.showMenu {
                    MenuView(viewOrders: self.$viewOrders, viewCashbackHistory: self.$cashbackHistory, showSelf: self.$showMenu)
                        .gesture(drag)
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
        }.gesture(drag).onAppear(){
            customer = Helpers.retrieveStoredCustomer()
        }
    }
    
    var navBarMenu : some View {
        Button(action: {
            self.showMenu.toggle()
        }) {
            Image("Menu").renderingMode(.original)
        }
    }
}
