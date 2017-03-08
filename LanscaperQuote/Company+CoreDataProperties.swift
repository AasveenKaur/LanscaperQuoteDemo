//
//  Company+CoreDataProperties.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company");
    }

    @NSManaged public var companyEmail: String?
    @NSManaged public var companyLogo: String?
    @NSManaged public var companyName: String?

}
