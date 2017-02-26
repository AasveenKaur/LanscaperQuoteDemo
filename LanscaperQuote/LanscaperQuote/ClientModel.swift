//
//  ClientModel.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/29/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class ClientModel: NSObject , NSCoding {
    var clientID: String = NSUUID().uuidString
    var name: String = ""
    var email: String = ""
    var phoneOne: String? = ""
    var phoneTwo: String? = ""
    var address:AddressModel? = AddressModel()
    var notes:String? = ""

    init(clientID: String = "" ,name: String = "", email: String = "",phoneOne: String = "",phoneTwo: String = "",address:AddressModel = AddressModel(),notes:String = "") {
        self.clientID = NSUUID().uuidString
        self.name = name
        self.email = email
        self.phoneTwo = phoneTwo
        self.phoneOne = phoneOne
        self.address = address
        
    }
    


 public func encode(with aCoder: NSCoder) {
            aCoder.encode(clientID, forKey: "clientID")
            aCoder.encode(name, forKey: "name")
            aCoder.encode(email, forKey: "email")
            aCoder.encode(phoneOne, forKey: "phoneOne")
            aCoder.encode(phoneTwo, forKey: "phoneTwo")
            aCoder.encode(address, forKey: "address")
            aCoder.encode(notes, forKey: "notes")
    
    }
    
    required init?(coder aDecoder: NSCoder) {
  
        clientID = aDecoder.decodeObject(forKey: "clientID") as! String
        name = aDecoder.decodeObject(forKey: "name") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        phoneOne = (aDecoder.decodeObject(forKey: "phoneOne") as! String)
        phoneTwo = (aDecoder.decodeObject(forKey: "phoneTwo") as! String)
        address = (aDecoder.decodeObject(forKey: "address") as! AddressModel)
        notes = (aDecoder.decodeObject(forKey: "notes") as! String)
}

}
