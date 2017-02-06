//
//  DataManager.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/31/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    
    
    func saveQuotes(Quotelist:[QuotesModel]) {
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(Quotelist, toFile: filePath)
        }
    }
    
    func loadQuotes()  -> [QuotesModel]?{
        if let filePath = pathForItems(), FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [QuotesModel] {
               let  Quotelist = archivedItems
                return Quotelist
            }
        }
        return nil
    }
    
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("quote.plist")?.path
        }
        
        return nil
    }
    
}
