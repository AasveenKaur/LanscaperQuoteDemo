//
//  Client+CoreDataClass.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData

@objc(Client)
public class Client: NSManagedObject {

    class func createClient(_ moc: NSManagedObjectContext, clientModel: ClientModel) -> Client {
        let newClient = NSEntityDescription.insertNewObject(forEntityName: "Client", into: moc) as! Client
        newClient.name = clientModel.name
        newClient.email = clientModel.email
        newClient.phoneOne = clientModel.phoneOne
        newClient.phoneTwo = clientModel.phoneTwo
        newClient.note = clientModel.notes
        
        let newAddress = Address.createAddress(moc, addressModel: clientModel.address!)
        newClient.clientAddress = newAddress
        return newClient
    }
    
    
}
