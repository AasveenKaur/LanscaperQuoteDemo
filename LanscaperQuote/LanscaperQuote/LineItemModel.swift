//
//  ClientModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class LineItemModel: NSObject , NSCoding{
    var lineItemID: String = NSUUID().uuidString
    var name: String = ""
    var lineItemdescription: String = ""
    var quantity: Float = 0.0
    var price: Float = 0.0
    var tax: Float = 0.0
    
    init(lineItemID: String,name: String,lineItemdescription: String,quantity: Float ,price: Float,tax: Float) {
        super.init()
        self.lineItemID = lineItemID
         self.name = name
         self.lineItemdescription = lineItemdescription
         self.quantity = quantity
        self.price = price
        self.tax = tax
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(lineItemID, forKey: "lineItemID")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(lineItemdescription, forKey: "lineItemdescription")
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(quantity, forKey: "price")
        aCoder.encode(quantity, forKey: "tax")
    }
    
   required convenience init?(coder aDecoder: NSCoder) {
    
        
         let lineItemID = aDecoder.decodeObject(forKey:"lineItemID") as? String
         let name = aDecoder.decodeObject(forKey:"name") as? String
         let lineItemdescription = aDecoder.decodeObject(forKey:"lineItemdescription") as? String
         let quantity = aDecoder.decodeObject(forKey:"quantity") as? Float
         let price = aDecoder.decodeObject(forKey:"price") as? Float
         let tax = aDecoder.decodeObject(forKey:"tax") as? Float
    
    self.init(lineItemID: lineItemID!,name: name!,lineItemdescription: lineItemdescription!,quantity: quantity! ,price: price!,tax: tax!)
        
        
    }
}
