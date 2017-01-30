//
//  QuotesModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class QuotesModel: NSObject {
    var quoteID: String = NSUUID().uuidString
    var client: ClientModel = ClientModel()
    var LineItems:Array = [LineItemModel]()
    var totalAmount: Float = 0.0
    var notes: String = ""
    var attachments : Array = [String]()
    var contractStatement : String = ""
    var clientSignature: String = ""
    var clientSignatureNeeded: Bool = true
    var mySignature:String = ""
    var mySignatureNeeded: Bool = true
    var date:Date = Date.init()
    var poNumber: String = ""
    var invoiceStatus: Bool = false
    var sentToClient: Bool = false
    
    
}
