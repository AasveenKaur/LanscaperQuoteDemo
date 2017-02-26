//
//  Address+CoreDataProperties.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address");
    }

    @NSManaged public var city: String?
    @NSManaged public var lineOne: String?
    @NSManaged public var lineTwo: String?
    @NSManaged public var state: String?
    @NSManaged public var zipCode: String?
    
    @NSManaged public var clientAtAddress: Client?
    @NSManaged public var userAtAddress: User?

}
