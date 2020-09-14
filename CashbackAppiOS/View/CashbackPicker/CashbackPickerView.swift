//
//  CashbackPickerView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 14/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CashbackPickerView: View {
    @State var flipped:Bool = false
    var body: some View {
        VStack {
            HStack () {
                CashabackCard(flipped: self.$flipped)
                CashabackCard(flipped: self.$flipped)
            }
            HStack () {
                CashabackCard(flipped: self.$flipped)
                CashabackCard(flipped: self.$flipped)
            }
        }
    }
}
