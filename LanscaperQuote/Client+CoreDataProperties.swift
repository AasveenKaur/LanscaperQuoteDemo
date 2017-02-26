//
//  Client+CoreDataProperties.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client");
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var phoneOne: String?
    @NSManaged public var phoneTwo: String?
    @NSManaged public var quotes: NSSet?
    @NSManaged public var clientAddress: Address?

}

// MARK: Generated accessors for quotes
extension Client {

    @objc(addQuotesObject:)
    @NSManaged public func addToQuotes(_ value: Quote)

    @objc(removeQuotesObject:)
    @NSManaged public func removeFromQuotes(_ value: Quote)

    @objc(addQuotes:)
    @NSManaged public func addToQuotes(_ values: NSSet)

    @objc(removeQuotes:)
    @NSManaged public func removeFromQuotes(_ values: NSSet)

}
