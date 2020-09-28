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
    @State var userFlip:Bool = false
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            if userFlip == false {
                Text("Pick Your Cashback!").font(.largeTitle)
                Text("You'll get more than \(tempCashback![0].removeZerosFromEnd())")
                
                fourCardView
            } else {
                Spacer()
                Text("CONGRATS! You have won: ").font(.title)
                WinnerCard()
                Text("Screenshot and post this on your instagram story to win another 50₹ (make sure to tag @revenoshopping)").font(.headline)
                Spacer()
            }
        }.onAppear(){transactionId = nil}
    }
    
    var fourCardView : some View {
        VStack {
            HStack () {
                CashbackCard(flipped: self.$flipped1, userFlipped: self.$userFlip, cardName: "card1").frame(width: 180,height: 250)
                CashbackCard(flipped: self.$flipped2, userFlipped: self.$userFlip, cardName: "card2").frame(width: 180,height: 250)
            }
            
            HStack () {
                CashbackCard(flipped: self.$flipped3, userFlipped: self.$userFlip, cardName: "card3").frame(width: 180,height: 250)
                CashbackCard(flipped: self.$flipped4, userFlipped: self.$userFlip, cardName: "card4").frame(width: 180,height: 250)
            }
            
            Spacer()
        }
    }
}
