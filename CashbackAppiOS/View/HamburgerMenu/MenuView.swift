//
//  NavigationDrawer.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var viewOrders:Bool
    @Binding var viewCashbackHistory:Bool
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
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("My Orders")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.onTapGesture {
                guard SkipChecker().skip == false else {
                    SkipChecker().makeUserLogin()
                    return
                }
                self.showSelf.toggle()
                self.viewOrders.toggle()
            }
            .padding(.top, 30)
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Earnings List")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.onTapGesture {
                guard SkipChecker().skip == false else {
                    SkipChecker().makeUserLogin()
                    return
                }
                self.showSelf.toggle()
                self.viewCashbackHistory.toggle()
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}
