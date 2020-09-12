//
//  OTPVerificationView.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 09/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct OTPVerificationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var otp = ""
    @State private var toMainActivity = false
    @State private var toRegistrationActivity = false
    
    @State private var showsLoadingAlert = false
    @State private var otpVerificationTitle = "Please wait while we verify your OTP"
    @State private var otpVerificationMessage = ""
    @State private var toggleLoader = false
    
    var userVM = UserViewModel()
    var countryCode:String
    var phoneNumber:String
    @Binding var authenticationID:String
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 20){
                Text("Enter OTP").font(Font.system(size:25).weight(.black)).fontWeight(.heavy).padding(.top, 70)
                
                Text("Enter the OTP code that you have received via sms for mobile number verification here")
                    .font(Font.system(size:13))
                    .foregroundColor(.gray)
                    .padding(.top, 12)
                
                TextField("OTP", text: self.$otp)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(UIColor.textFieldLightGrey))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button (action: {
                    Helpers.endEditing()
                    self.toggleLoader.toggle()
                    self.registerUser()
                }) {
                    Text("Confirm OTP").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }.foregroundColor(.white)
                    .background(Color(UIColor.supportTextBlue))
                    .padding(.top, 5)
                    .cornerRadius(10)
                Spacer()
            }.padding()

            NavigationLink(destination: UserRegistration(countryCode: self.countryCode, phoneNumber: self.phoneNumber), isActive: self.$toRegistrationActivity) {EmptyView()}.hidden()
            
            if self.toggleLoader {
                GeometryReader { geo in
                    Loader()
                }.background(Color.black.opacity(0.45)).edgesIgnoringSafeArea(.all)
            }
            
        }.keyboardAdaptive(specificOffSet: 0).onDisappear(){self.presentationMode.wrappedValue.dismiss()}.alert(isPresented: $showsLoadingAlert) {
            Alert(title: Text(self.otpVerificationTitle), message: Text(self.otpVerificationMessage), dismissButton: .default(Text("Try Again")))
        }
    }
    
    func registerUser () {
        PhoneAuthHelper.registerUser(self.authenticationID, self.otp) { verified in
            if verified == true {
                self.userVM.fetchUser(Auth.auth().currentUser!.uid) { userExists in
                    if userExists {
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        self.showsLoadingAlert = false
                        self.toggleLoader = false
                    } else {
                        self.showsLoadingAlert = false
                        self.toggleLoader = false 
                        self.toRegistrationActivity.toggle()
                    }
                }
            } else {
                self.otpVerificationTitle = "Verification Failed"
                self.otpVerificationMessage = "Looks like the OTP you entered is wrong. Please try again."
                self.toggleLoader.toggle()
                self.showsLoadingAlert.toggle()
                
            }
        }
    }
}
