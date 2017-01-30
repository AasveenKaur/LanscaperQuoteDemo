//
//  ClientModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class ClientModel: NSObject {
    var clientID: String = NSUUID().uuidString
    var name: String = ""
    var email: String = ""
    var phoneOne: String = ""
    var phoneTwo: String = ""
    var address:AddressModel = AddressModel()
    var notes:String = ""
}
