//
//  Photo+CoreDataProperties.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 3/7/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var path: String?

}
