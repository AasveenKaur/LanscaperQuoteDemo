//
//  ClientModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class LineItemModel: NSObject {
    var lineItemID: String = NSUUID().uuidString
    var name: String = ""
    var description: String = ""
    var quantity: Float = 0.0
    var price: Float = 0.0
    var tax: Float = 0.0
}
