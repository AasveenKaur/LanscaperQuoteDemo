//
//  QuotesModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
import Foundation

class QuotesModel: NSObject, NSCoding {
 

    var quoteID: String = NSUUID().uuidString
    var estimateNumber:String = ""
    var client: ClientModel = ClientModel()
    var LineItems:Array? = [LineItemModel]()
    var totalAmount: Float? = 0.0
    var notes: String? = ""
    var attachments : Array? = [String]()
    var contractStatement : String? = ""
    var clientSignature: String? = ""
    var clientSignatureNeeded: Bool = true
    var mySignature:String? = ""
    var mySignatureNeeded: Bool = true
    var date:Date = Date.init()
    var poNumber: String? = ""
    var invoiceStatus: Bool = false
    var sentToClient: Bool = false
    
    
    init(quoteID: String = "",
         estimateNumber:String = "",
         client: ClientModel = ClientModel(),
         LineItems:Array<LineItemModel> = [],
         totalAmount: Float = 0.0,
         notes: String = "",
         attachments : Array<String> =  [],
         contractStatement : String = "",
         clientSignature: String = "",
         clientSignatureNeeded: Bool = true,
         mySignature:String = "",
         mySignatureNeeded: Bool = true,
         date:Date = Date.init(),
         poNumber: String? = "",
         invoiceStatus: Bool = false,
         sentToClient: Bool = false) {
        
        self.quoteID = NSUUID().uuidString
        self.estimateNumber = estimateNumber
        self.client = client
        self.LineItems = LineItems
        self.totalAmount = totalAmount
        self.notes = notes
        self.attachments = attachments
        self.contractStatement = contractStatement
        self.clientSignature = clientSignature
        self.clientSignatureNeeded = clientSignatureNeeded
        self.mySignature = mySignature
        self.mySignatureNeeded = mySignatureNeeded
        self.date = date
        self.poNumber = poNumber
        self.invoiceStatus = invoiceStatus
        self.sentToClient = sentToClient
    }
  
        
public func encode(with aCoder: NSCoder) {
        aCoder.encode(quoteID, forKey: "quoteID")
        aCoder.encode(estimateNumber, forKey: "estimateNumber")
        aCoder.encode(client, forKey: "client")
        aCoder.encode(LineItems, forKey: "LineItems")
        aCoder.encode(totalAmount, forKey: "totalAmount")
        aCoder.encode(notes, forKey: "notes")
        aCoder.encode(attachments, forKey: "attachments")
        aCoder.encode(contractStatement, forKey: "contractStatement")
        aCoder.encode(clientSignature, forKey: "clientSignature")
        aCoder.encode(clientSignatureNeeded, forKey: "clientSignatureNeeded")
        aCoder.encode(mySignature, forKey: "mySignature")
        aCoder.encode(mySignatureNeeded, forKey: "mySignatureNeeded")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(poNumber, forKey: "poNumber")
        aCoder.encode(invoiceStatus, forKey: "invoiceStatus")
        aCoder.encode(sentToClient, forKey: "sentToClient")
        
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
       
        
        quoteID = aDecoder.decodeObject(forKey: "quoteID") as! String
        estimateNumber = aDecoder.decodeObject(forKey: "estimateNumber") as! String
        client = aDecoder.decodeObject(forKey: "client") as! ClientModel
        LineItems = (aDecoder.decodeObject(forKey: "LineItems") as! [LineItemModel])
        totalAmount = aDecoder.decodeObject(forKey: "totalAmount") as! Float?
        notes = (aDecoder.decodeObject(forKey: "notes") as! String)
        attachments = (aDecoder.decodeObject(forKey: "attachments") as! [String])
        contractStatement = (aDecoder.decodeObject(forKey: "contractStatement") as! String)
        mySignature = (aDecoder.decodeObject(forKey: "mySignature") as! String)
        mySignatureNeeded = aDecoder.decodeBool(forKey: "mySignatureNeeded")
        clientSignature = (aDecoder.decodeObject(forKey: "clientSignature") as! String)
        clientSignatureNeeded = aDecoder.decodeBool(forKey: "clientSignatureNeeded")
        date = aDecoder.decodeObject(forKey: "date") as! Date
        poNumber = (aDecoder.decodeObject(forKey: "poNumber") as! String)
        invoiceStatus = aDecoder.decodeBool(forKey: "invoiceStatus")
        sentToClient = aDecoder.decodeBool(forKey: "sentToClient")
    }
    
    
}
