//
//  LineItem+CoreDataClass.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData

@objc(LineItem)
public class LineItem: NSManagedObject {
    
    
    
class func createLineItem(_ moc: NSManagedObjectContext, lineItemModel: LineItemModel) -> LineItem {
    
    let name = lineItemModel.name
    let price = lineItemModel.price
    let quantity = lineItemModel.quantity
    let existingItem = lineItems(moc, itemName: name, itemPrice: price, itemQuantity: quantity)
    if existingItem.count == 1 {
        return existingItem[0] as! LineItem
    }
    let newLineItem = NSEntityDescription.insertNewObject(forEntityName: "LineItem", into: moc) as! LineItem
    
    newLineItem.itemName = lineItemModel.name
    newLineItem.itemDescription = lineItemModel.lineItemdescription
    newLineItem.price = lineItemModel.price
    newLineItem.tax = lineItemModel.tax
    newLineItem.quantity = lineItemModel.quantity
    
   return newLineItem
    }
    
    class func lineItems(_ moc: NSManagedObjectContext, itemName: String,itemPrice: Float, itemQuantity: Float ) -> NSArray {
        let model = moc.persistentStoreCoordinator?.managedObjectModel
        let request = model?.fetchRequestFromTemplate(withName: "lineItemWithName",
                                                      substitutionVariables: ["MyName":itemName, "MyPrice": itemPrice, "MyQuantity":itemQuantity])
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
