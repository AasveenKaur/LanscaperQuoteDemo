//
//  Quote+CoreDataProperties.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 3/7/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote");
    }

    @NSManaged public var contractStatement: String?
    @NSManaged public var date: String?
    @NSManaged public var discount: Float
    @NSManaged public var estimateNumber: String?
    @NSManaged public var invoiceStatus: Bool
    @NSManaged public var note: String?
    @NSManaged public var poNumber: String?
    @NSManaged public var quoteID: String?
    @NSManaged public var sentToClient: Bool
    @NSManaged public var totalAmount: Float
    @NSManaged public var client: Client?
    @NSManaged public var lineItems: NSSet?
    @NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for lineItems
extension Quote {

    @objc(addLineItemsObject:)
    @NSManaged public func addToLineItems(_ value: LineItem)

    @objc(removeLineItemsObject:)
    @NSManaged public func removeFromLineItems(_ value: LineItem)

    @objc(addLineItems:)
    @NSManaged public func addToLineItems(_ values: NSSet)

    @objc(removeLineItems:)
    @NSManaged public func removeFromLineItems(_ values: NSSet)

}

// MARK: Generated accessors for photos
extension Quote {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}
