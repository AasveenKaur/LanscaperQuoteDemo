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
    let newLineItem = NSEntityDescription.insertNewObject(forEntityName: "LineItem", into: moc) as! LineItem
    
    newLineItem.itemName = lineItemModel.name
    newLineItem.itemDescription = lineItemModel.lineItemdescription
    newLineItem.price = lineItemModel.price
    newLineItem.tax = lineItemModel.tax
    newLineItem.quantity = lineItemModel.quantity
    
   return newLineItem
    }
}
