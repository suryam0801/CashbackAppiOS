//
//  UserRegistration.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 27/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct UserRegistration: View {
    var countryCode:String
    var phoneNumber:String
    @State private var image:Image?
    @State private var showingImagePicker = false
    @State private var inputImage:UIImage?
    @State private var selectedDefaultImageName:String = ""
    @State private var userName:String = ""
    @State private var showsLoadingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Circle").font(.custom("Roboto-Black", size: 70)).foregroundColor(Color(UIColor.titleColorDarkBlue))
                
                Text("Choose your profile picture").font(Font.system(size:13)).foregroundColor(Color(UIColor.titleColorDarkBlue))
                
                ZStack {
                    if image != nil {
                        image?
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .overlay(Circle().stroke(Color.white,lineWidth:1).shadow(radius: 10))
                    } else {
                        Image("person.crop.circle.fill").resizable().frame(width:80, height: 80).foregroundColor(.gray)
                    }
                }.frame(width:95, height: 90)
                
                HStack (spacing: 15){
                    Image("avatar1").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 1)}
                    Image("avatar2").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 2)}
                    Image("avatar3").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 3)}
                    Image("avatar4").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 4)}
                }.padding()
                
                HStack (spacing: 15){
                    Image("avatar5").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 5)}
                    Image("avatar6").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 6)}
                    Image("avatar7").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 7)}
                    Image("avatar8").resizable().frame(width:60, height: 60).onTapGesture {self.updateDefaultImageChoice(avatarNumber: 8)}
                }.padding(.bottom, 30)
                
                TextField("Username", text: self.$userName)
                    .padding()
                    .background(Color(UIColor.textFieldLightGrey))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button (action: {self.createUser()}) {
                    Text("Finish Registration").font(Font.system(size:17).weight(.bold)).frame(width: UIScreen.main.bounds.width-30,height: 50)
                }.foregroundColor(.white)
                    .background(Color(UIColor.supportTextBlue))
                    .cornerRadius(10)
                Spacer()
            }.keyboardAdaptive(specificOffSet: 10).padding()
            
        }.alert(isPresented: $showsLoadingAlert) {
            Alert(title: Text("Please enter your name"), dismissButton: .default(Text("Ok")))
        }.navigationBarTitle("").navigationBarHidden(true)
    }
    
    func updateDefaultImageChoice (avatarNumber:Int) {
        self.image = Image("avatar\(avatarNumber)")
        self.selectedDefaultImageName = "avatar\(avatarNumber)"
    }

    func createUser () {
        
        guard !self.userName.isEmpty else {
            self.showsLoadingAlert.toggle()
            return
        }
        
        var user:Customer?
        
        user = Customer(id: PhoneAuthHelper.getUserId(), name: self.userName, phnNumber: self.countryCode + "" + self.phoneNumber, address: nil, deviceToken: FirebaseTokenHelper.getToken(), upi: "", version: 0, cart: nil)

        //TODO: ADD FIREBASE AUTH
        DBWriteHelper().createNewCustomer(userObj: user!) { createdUser in
            if createdUser {
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }
        }
    }
}
