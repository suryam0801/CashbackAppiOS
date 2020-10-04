//
//  SharePopupHelper.swift
//  CashbackAppiOS
//
//  Created by Surya Manivannan on 04/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import SwiftUI

struct SharePopup {
    static func sharePopup (id:String, name:String) {
        let titleText:String = "Checkout this awesome deal: \(name) \n\n"
        let av = UIActivityViewController(activityItems: [titleText, getLink(id: id)], applicationActivities: nil)

        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }

    static func getLink (id:String) -> URL {
        let url = URL(string: "https://onfio.app.link/reveno/?\(id)")

        return url!
    }
}
