//
//  User.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 09/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

struct Customer : Codable {
    var id:String!
    let name:String!
    var phnNumber:String!
    let addresses:[String]!
    var deviceToken:String!
    var upi:String!
    var version:Int!
    var cart:[String:CartItem]!
}
