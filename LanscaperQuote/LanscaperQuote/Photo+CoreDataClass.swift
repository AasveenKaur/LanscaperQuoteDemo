//
//  Photo+CoreDataClass.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 3/7/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {

    class func createOrFindPhoto(_ moc: NSManagedObjectContext, photoPath: String) -> Photo {
        let existingPhoto = photos(moc, path: photoPath)
        if existingPhoto.count == 1 {
            return existingPhoto[0] as! Photo
        }
        let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: moc) as! Photo
        newPhoto.path = photoPath
        
        return newPhoto
    }
    
    class func photos(_ moc: NSManagedObjectContext, path: String) -> NSArray {
        let model = moc.persistentStoreCoordinator?.managedObjectModel
        let request = model?.fetchRequestFromTemplate(withName: "photoWithPath",
                                                      substitutionVariables: ["photoPath": path])
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
