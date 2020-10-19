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
    
    @State var showDetailedView = false
    @State var sharedItem:Item?
    
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

            NavigationView {
                ZStack (alignment: .leading) {
                    VStack(spacing: 15){

                        ItemsDisplayMainView()

                        Spacer()

                    }.offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                        .navigationBarTitle("Reveno", displayMode: .inline)
                        .edgesIgnoringSafeArea(.bottom)
                        .navigationBarItems(leading: self.navBarMenu, trailing: NavBarEndButtons())
                        .gesture(drag)

                    if self.showMenu {
                        MenuView(showSelf: self.$showMenu)
                            .gesture(drag)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                    VStack {
                        if self.showDetailedView {
                            NavigationLink(destination: DetailedItemView(item: self.sharedItem!), isActive: self.$showDetailedView) {
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }.onAppear(){
            customer = Helpers.retrieveStoredCustomer()
            PromoCodeViewModel().fetchPromoCodes()

            if sharedItemId != nil {
                SingleItemViewModel().fetchItem(sharedItemId!) { (item) in
                    self.sharedItem = item
                    sharedItemId = nil
                    self.showDetailedView.toggle()
                }
            }

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
