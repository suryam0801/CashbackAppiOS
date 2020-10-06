//
//  NavigationDrawer.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Binding var showSelf:Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                VStack (alignment: .center) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 100)
                    Text("\(customer?.name ?? "Profile")")
                        .foregroundColor(.gray)
                        .font(.headline)
                    Text("\(customer?.phnNumber ?? "Register")")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                }
                Spacer()
            }.padding(.top, 100)
            
            NavigationLink(destination: OrdersView()) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("My Orders")
                        .foregroundColor(.gray)
                        .font(.headline)
                }.padding(.top, 30)
            }.buttonStyle(PlainButtonStyle())

            
            NavigationLink(destination: CashbackHistoryView()) {
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Earnings List")
                        .foregroundColor(.gray)
                        .font(.headline)
                }.padding(.top, 30)
            }.buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}
