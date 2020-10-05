//
//  NavBarEndButtons.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct NavBarEndButtons: View {
    @Binding var showCart:Bool
    
    
    var body: some View {
        HStack (spacing: 18) {
            Button(action: {
                OpenInstagram.openInsta()
            }) {
                Image("instagram").resizable().frame(width: 25, height: 25)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                guard SkipChecker().skip == false else {
                    SkipChecker().makeUserLogin()
                    return
                }
                self.showCart.toggle()
            }) {
                
                Image("shop").renderingMode(.original)
            }
            
        }
    }
}
