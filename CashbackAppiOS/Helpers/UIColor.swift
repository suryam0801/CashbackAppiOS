//
//  UIColor.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 16/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let pollBackgroundBlue = UIColor().colorFromHex("#EFF6FF")
    static let pollForegroundBlue = UIColor().colorFromHex("#6CACFF")
    static let pollVotedIndicatorBlue = UIColor().colorFromHex("#D8E9FF")
    static let supportTextBlue = UIColor().colorFromHex("#6CACFF")
    static let secondaryTextGrey = UIColor().colorFromHex("#BDBDBD")
    static let textFieldLightGrey = UIColor().colorFromHex("#F8F8F8")
    static let titleColorDarkBlue = UIColor().colorFromHex("#158BF1")
    static let rejectButtonRed = UIColor().colorFromHex("#FF6161")
    static let newCommentsTeal = UIColor().colorFromHex("#36D1DC")
    static let acceptColorGreen = UIColor().colorFromHex("#10C977")
    
    func colorFromHex (_ hex:String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb : UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha: 1.0)
    }

}
