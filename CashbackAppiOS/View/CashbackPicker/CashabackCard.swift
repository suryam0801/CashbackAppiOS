//
//  CashabackCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CashabackCard: View {
    @Binding var flipped:Bool // state variable used to update the card
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(self.flipped ? .red : .blue) // change the card color when flipped
            .padding()
            .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            .animation(.default) // implicitly applying animation
            .onTapGesture {
                // explicitly apply animation on toggle (choose either or)
                //withAnimation {
                    self.flipped.toggle()
                //}
        }
        
    }
}
