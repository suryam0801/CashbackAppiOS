//
//  OnBoardingPageView.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 12/09/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct PageView: View {
    var title: String
    var imageName: String
    var header: String
    var content: String
    var textColor: Color
    
    let imageWidth: CGFloat = 150
    let textWidth: CGFloat = 350
    
    var body: some View {
        let size = UIImage(named: imageName)!.size
        let aspect = size.width / size.height
        
        return
            VStack(alignment: .center, spacing: 50) {
                VStack (spacing: 0) {
                    Text("Welcome To")
                        .font(Font.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(textColor)
                        .frame(width: textWidth)
                        .multilineTextAlignment(.center)
                    Text(title)
                        .font(Font.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(textColor)
                        .frame(width: textWidth)
                        .multilineTextAlignment(.center)
                }
                Image(imageName)
                    .resizable()
                    .aspectRatio(aspect, contentMode: .fill)
                    .frame(width: imageWidth, height: imageWidth)
                VStack(alignment: .center, spacing: 5) {
                    Text(header)
                        .font(Font.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(textColor)
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                    Text(content)
                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(textColor)
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                }
            }.padding(60)
    }
}

struct OnBoardingData {
    static let title = "Reveno"
    
    static let headers = [
        "Instant Cashback",
        "Exclusive Designs"
    ]

    static let contentStrings = [
        "Get instant, guaranteed cashbacks for every purchase!",
        "Get access to the best hot designs that change every week!"
    ]

    static let imageNames = [
        "cashback",
        "exclusive"
    ]

    static let colors = [
        "FCE38A",
        "EAFFD0"
        ].map{ Color(hex: $0) }

    static let textColors = [
        "4A4A4A",
        "4A4A4A"
        ].map{ Color(hex: $0) }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
