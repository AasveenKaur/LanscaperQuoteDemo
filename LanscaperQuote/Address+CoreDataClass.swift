//
//  Address+CoreDataClass.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {
    class func createAddress(_ moc: NSManagedObjectContext, addressModel: AddressModel) -> Address {
        let newAddress = NSEntityDescription.insertNewObject(forEntityName: "Address", into: moc) as! Address
        newAddress.lineOne = addressModel.addressLineOne
        newAddress.lineTwo = addressModel.addressLineTwo
        newAddress.city = addressModel.city
        newAddress.state = addressModel.state
        newAddress.zipCode = addressModel.zipCode
        
        return newAddress
}

}
