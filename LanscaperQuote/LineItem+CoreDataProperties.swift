//
//  LineItem+CoreDataProperties.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData


extension LineItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LineItem> {
        return NSFetchRequest<LineItem>(entityName: "LineItem");
    }

    @NSManaged public var itemDescription: String?
    @NSManaged public var itemName: String?
    @NSManaged public var price: Float
    @NSManaged public var quantity: Float
    @NSManaged public var tax: Float
    @NSManaged public var lineItemsQuotes: NSSet?

}

// MARK: Generated accessors for lineItemsQuotes
extension LineItem {

    @objc(addLineItemsQuotesObject:)
    @NSManaged public func addToLineItemsQuotes(_ value: Quote)

    @objc(removeLineItemsQuotesObject:)
    @NSManaged public func removeFromLineItemsQuotes(_ value: Quote)

    @objc(addLineItemsQuotes:)
    @NSManaged public func addToLineItemsQuotes(_ values: NSSet)

    @objc(removeLineItemsQuotes:)
    @NSManaged public func removeFromLineItemsQuotes(_ values: NSSet)

}
