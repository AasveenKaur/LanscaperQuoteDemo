//
//  ClientModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class AddressModel: NSObject, NSCoding {
    
    var addressLineOne: String = ""
    var addressLineTwo: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    
    init(addressLineOne: String = "",addressLineTwo: String = "",city: String = "",state: String = "", zipCode: String = "" ) {
        self.addressLineOne = addressLineOne
        self.addressLineTwo = addressLineTwo
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
    required init?(coder aDecoder: NSCoder) {
         addressLineOne = aDecoder.decodeObject(forKey:"addressLineOne") as! String
         addressLineTwo = aDecoder.decodeObject(forKey:"addressLineTwo") as! String
         city = aDecoder.decodeObject(forKey:"city") as! String
         state = aDecoder.decodeObject(forKey:"state") as! String
         zipCode = aDecoder.decodeObject(forKey:"zipCode") as! String
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(addressLineOne, forKey: "addressLineOne")
        aCoder.encode(addressLineTwo, forKey: "addressLineTwo")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(zipCode, forKey: "zipCode")
        
    }

}

