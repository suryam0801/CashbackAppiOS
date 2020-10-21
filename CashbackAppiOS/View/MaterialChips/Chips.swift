//
//  Chips.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 21/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
struct Chips: View {
    let titleKey: String //text or localisation value
    var isSelected: Bool
    let callback:(String)->()
    
    init(titleKey: String,
         isSelected: Bool,
         callback: @escaping (String) -> ()
    ){
        self.titleKey = titleKey
        self.isSelected = isSelected
        self.callback = callback
    }
    
    var body: some View {
        Text(titleKey).font(.system(size: 13)).lineLimit(nil)
            .padding(.all, 10)
            .foregroundColor(isSelected ? .white : .blue)
            .background(isSelected ? Color.blue : Color.white) //different UI for selected and not selected view
            .cornerRadius(40)  //rounded Corner
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.blue, lineWidth: 1.5)
                
            ).onTapGesture {
                self.callback(self.titleKey)
            }
    }
}
