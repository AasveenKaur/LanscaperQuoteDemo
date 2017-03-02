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
        let clientName = clientModel.name
        let existingClient = clients(moc, name: clientName)
        if existingClient.count == 1 {
            return existingClient[0] as! Client
        }
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
    
    class func clients(_ moc: NSManagedObjectContext, name: String) -> NSArray {
        let model = moc.persistentStoreCoordinator?.managedObjectModel
        let request = model?.fetchRequestFromTemplate(withName: "clientWithName",
                                                      substitutionVariables: ["clientName": name])
        do {
            let result = try moc.fetch(request!)
            return result as NSArray
        }
        catch {
            print ("fetch", request!, "failed:", error)
            abort()
        }
    }

    
}
