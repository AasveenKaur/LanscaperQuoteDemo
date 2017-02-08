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
    
 
    
    init(lineItemID: String = "",
         name:String = "",
         lineItemdescription: String = "",
         quantity:Float = 0.0,
         price: Float = 0.0,
         tax: Float = 0.0
        ) {
        self.lineItemID = NSUUID().uuidString
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
    
   required  init?(coder aDecoder: NSCoder) {
    
        
          lineItemID = aDecoder.decodeObject(forKey:"lineItemID") as! String
          name = aDecoder.decodeObject(forKey:"name") as! String
          lineItemdescription = aDecoder.decodeObject(forKey:"lineItemdescription") as! String
          quantity = aDecoder.decodeObject(forKey:"quantity") as! Float
          price = aDecoder.decodeObject(forKey:"price") as! Float
          tax = aDecoder.decodeObject(forKey:"tax") as! Float
    
    }
}
