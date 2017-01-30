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
    //var client: ClientModel = ClientModel()
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
    
    init(quoteID: String,LineItems: [LineItemModel],totalAmount: Float,notes: String, attachments : [String],contractStatement : String,clientSignature: String,clientSignatureNeeded: Bool,mySignature:String,mySignatureNeeded: Bool,date:Date,poNumber: String,invoiceStatus: Bool,sentToClient: Bool ) {
        super.init()
        self.quoteID = quoteID
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
        //coder.encode(client, forKey: "client")
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        
         let quoteID = aDecoder.decodeObject(forKey: "quoteID") as! String
       
        
        /* if let client = decoder.decodeObject(forKey: "client") as? ClientModel {
         self.client = client
         }*/
        
         let LineItems = aDecoder.decodeObject(forKey: "LineItems") as! [LineItemModel]
       
        
         let totalAmount = aDecoder.decodeObject(forKey: "totalAmount") as! Float
      
         let notes = aDecoder.decodeObject(forKey: "notes") as? String
       
         let attachments = aDecoder.decodeObject(forKey: "attachments") as! [String]
       
         let contractStatement = aDecoder.decodeObject(forKey: "contractStatement") as! String
       
         let clientSignature = aDecoder.decodeObject(forKey: "clientSignature") as! String
       
        let clientSignatureNeeded = aDecoder.decodeObject(forKey: "clientSignatureNeeded") as! Bool
       
         let mySignature = aDecoder.decodeObject(forKey: "mySignature") as! String
        
         let mySignatureNeeded = aDecoder.decodeObject(forKey: "mySignatureNeeded") as! Bool
       
        
         let date = aDecoder.decodeObject(forKey: "date") as! Date
       
         let poNumber = aDecoder.decodeObject(forKey: "poNumber") as! String
       
         let invoiceStatus = aDecoder.decodeObject(forKey: "invoiceStatus") as! Bool
        
         let sentToClient = aDecoder.decodeObject(forKey: "sentToClient") as! Bool
        
        
       
        self.init(quoteID: quoteID,LineItems: LineItems,totalAmount: totalAmount,notes: notes!, attachments : attachments,contractStatement : contractStatement,clientSignature: clientSignature,clientSignatureNeeded: clientSignatureNeeded,mySignature:mySignature,mySignatureNeeded: mySignatureNeeded,date:date,poNumber: poNumber,invoiceStatus: invoiceStatus,sentToClient: sentToClient )

    }
    
    
}
