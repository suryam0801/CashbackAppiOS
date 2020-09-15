//
//  WinnerCard.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 15/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct WinnerCard: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.acceptColorGreen)) // change the card color when flipped
                .padding()
            Text("\(givenCashback!)₹").font(.system(size: 50)).foregroundColor(Color.white)
        }
    }
    
}
