//
//  CashabackCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CashbackCard: View {
    @Binding var flipped:Bool // state variable used to update the card
    var cardName:String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(self.flipped ? Color(UIColor.rejectButtonRed) : Color(UIColor.titleColorDarkBlue)) // change the card color when flipped
                .padding()
                .rotation3DEffect(self.flipped ? Angle(degrees: 540): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                .animation(.default) // implicitly applying animation
                .onTapGesture {
                    if userFlip == nil {
                        self.flipped.toggle()
                        userFlip = self.cardName
                    }
            }

            if flipped {
                Text((helperFlip != nil) ? "\(givenCashback!)" : "\(revealCashback!)").font(.system(size: 50)).foregroundColor(Color.white)
            }
        }
    }
}
