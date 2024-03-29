//
//  LoginView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct PhoneVerificationview: View {
    
    @State private var userNumber = ""
    @State private var countryCode = "+91"
    @State private var userID = ""
    @State private var OTPSend = false
    @State var showCountryCodePicker = false
    
    @State private var showsLoadingAlert = false
    @State private var phoneVerificationTitle = "Please wait while we verify your Ph"
    @State private var otpVerificationMessage = ""
    @State private var toggleLoader = false

    //User Interface
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    
                    HStack {
                        Spacer()
                        Button (action: {
                            UserDefaults.standard.set(true, forKey: "skip")
                            NotificationCenter.default.post(name: NSNotification.Name("skipChange"), object: nil)
                        }) {
                            Text("Skip").font(.subheadline).foregroundColor(.gray)
                        }
                    }.padding()
                    
                    Text("Reveno").font(.system(size: 70)).bold().foregroundColor(Color(UIColor.titleColorDarkBlue)).padding(.top, 50)
                    
                    Text("The shopping app that pays you back").font(Font.system(size:13)).foregroundColor(.gray)
                    
                    Text("Verify Your Number").font(Font.system(size:25).weight(.bold)).fontWeight(.heavy).padding(.top, 70)
                    
                    Text("Please enter the same as your UPI PHONENUMBER so we can send your cashback")
                        .bold()
                        .font(Font.system(size:13))
                        .foregroundColor(.gray)
                        .padding()

                    HStack{
                        Text(self.countryCode).frame(width: 35)
                            .padding()
                            .onTapGesture {self.showCountryCodePicker.toggle()}
                            .background(Color(UIColor.textFieldLightGrey))
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        TextField("Number", text: self.$userNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(UIColor.textFieldLightGrey))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } .padding([.leading, .trailing, .bottom], 15)

                    Button (action: {
                        if self.numberValidityCheck(number: self.userNumber) {
                            self.toggleLoader.toggle()
                            Helpers.endEditing()
                            self.phoneVerification()
                        } else {
                            self.phoneVerificationTitle = "Please enter a valid number"
                            self.showsLoadingAlert.toggle()
                            Helpers.endEditing()
                        }
                    }) {
                        Text("Next").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                    }.foregroundColor(.white)
                        .background(Color(UIColor.supportTextBlue))
                        .padding(.top, 5)
                        .cornerRadius(10)

                    NavigationLink(destination: OTPVerificationView(countryCode: self.countryCode, phoneNumber: self.userNumber, authenticationID: self.$userID), isActive: self.$OTPSend) {EmptyView()}.hidden()

                    Spacer()
                }.keyboardAdaptive(specificOffSet: 0).onTapGesture { Helpers.endEditing() }
                if self.toggleLoader {
                    GeometryReader { geo in
                        Loader()
                    }.background(Color.black.opacity(0.45)).edgesIgnoringSafeArea(.all)
                }
            }.navigationBarTitle("").navigationBarHidden(true)

        }.sheet(isPresented: self.$showCountryCodePicker) {
            CountryPickerView(selectedCountryCode: self.$countryCode, countryPickerViewDismisser: self.$showCountryCodePicker)
        }.alert(isPresented: $showsLoadingAlert) {
            Alert(title: Text(self.phoneVerificationTitle), message: Text(self.otpVerificationMessage), dismissButton: .default(Text("Dismiss")))
        }
    }

    func phoneVerification() {
        PhoneAuthHelper.phoneNumberVerification(self.countryCode, self.userNumber) { verified, ID in
            if verified == true {
                self.userID = ID!
                self.showsLoadingAlert = false
                self.toggleLoader = false
                self.OTPSend.toggle()
            } else {
                self.phoneVerificationTitle = "Please enter a valid number"
                self.otpVerificationMessage = "Looks like your number is invalid. Please renter"
                Helpers.endEditing()
                self.toggleLoader = false
                self.showsLoadingAlert.toggle()
            }
        }
    }

    func numberValidityCheck (number:String) -> Bool {
        var valid:Bool = false
        do{
            //checks if the number is valid
            if try PhoneAuthHelper.validatePhoneNumber(self.userNumber) == self.userNumber {
                valid = true
            }
            
        } catch let error {
            print(error)
        }

        return valid
    }

}
