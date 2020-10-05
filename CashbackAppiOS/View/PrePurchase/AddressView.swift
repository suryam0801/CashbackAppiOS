//
//  AddressView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 28/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @State private var city:String = ""
    @State private var state:String = ""
    @State private var street:String = ""
    @State private var zipcode:String = ""
    @State private var apartmentOrHouseNumber:String = ""
    
    @Binding var showAddressPicker:Bool
    @Binding var address:String
    
    var body: some View {
        VStack {
            Text("Please Enter Your Address").font(Font.system(size:25).weight(.bold)).fontWeight(.heavy).padding(.top, 30)
            TextField("City", text: self.$city).modifier(TextEditBackground())
            TextField("State", text: self.$state).modifier(TextEditBackground())
            TextField("Street", text: self.$street).modifier(TextEditBackground())
            TextField("Zipcode", text: self.$zipcode).modifier(TextEditBackground())
            TextField("Apartment/House Number", text: self.$apartmentOrHouseNumber).modifier(TextEditBackground())
            
            Button (action: {
                self.address = self.street + ", " + self.city + ", " + self.state + ", " + self.apartmentOrHouseNumber + ", " +  self.zipcode + ", "

                customer?.address = self.address
                DBWriteHelper().updateAddresses()
                self.showAddressPicker.toggle()
                
            }) {
                Text("Done").frame(width: UIScreen.main.bounds.width - 30,height: 50)
            }.foregroundColor(.white)
                .background(Color(UIColor.supportTextBlue))
                .padding(.top, 5)
                .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct TextEditBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(UIColor.textFieldLightGrey))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
