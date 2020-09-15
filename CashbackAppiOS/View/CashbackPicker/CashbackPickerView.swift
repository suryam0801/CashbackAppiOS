//
//  CashbackPickerView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CashbackPickerView: View {
    @State var flipped1:Bool = false
    @State var flipped2:Bool = false
    @State var flipped3:Bool = false
    @State var flipped4:Bool = false
    @State var helperFlip:Bool = false
    @State var userFlip:Bool = false

    var body: some View {
        VStack {
            if userFlip == false {
                fourCardView
            } else {
                Text("CONGRATS! Your cashback reflect in your account within 24 hours!").font(.title)
                WinnerCard()
                Spacer()
            }
        }
    }
    
    var fourCardView : some View {
        VStack {
            HStack () {
                CashbackCard(flipped: self.$flipped1, helperFlipped: self.$helperFlip, userFlipped: self.$userFlip, cardName: "card1").frame(width: 180,height: 250)
                CashbackCard(flipped: self.$flipped2, helperFlipped: self.$helperFlip, userFlipped: self.$userFlip, cardName: "card2").frame(width: 180,height: 250)
            }

            HStack () {
                CashbackCard(flipped: self.$flipped3, helperFlipped: self.$helperFlip, userFlipped: self.$userFlip, cardName: "card3").frame(width: 180,height: 250)
                CashbackCard(flipped: self.$flipped4, helperFlipped: self.$helperFlip, userFlipped: self.$userFlip, cardName: "card4").frame(width: 180,height: 250)
            }

            Spacer()

            Text("Need Help?").font(.largeTitle)
            Button(action: {
                
                guard self.helperFlip == false, self.userFlip == false else {return}
                
                let toFlip = Int.random(in: 1..<4)
                
                if toFlip == 1 {
                    self.flipped1.toggle()
                } else if toFlip == 2 {
                    self.flipped2.toggle()
                } else if toFlip == 3 {
                    self.flipped3.toggle()
                } else if toFlip == 4 {
                    self.flipped4.toggle()
                }
                
                self.helperFlip = true
            }) {
                Text("Click To Reveal 1 Card")
            }
        }
    }
}
