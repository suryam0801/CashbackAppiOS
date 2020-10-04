//
//  OpenInstagram.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 04/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import UIKit

class OpenInstagram {
    static func openInsta () {
        guard let instagram = URL(string: "https://www.instagram.com/revenostore") else { return }
        UIApplication.shared.open(instagram)
    }
}
