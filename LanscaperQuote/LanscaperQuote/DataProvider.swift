//
//  DataProvider.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/30/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class DataProvider: NSObject {

    
    //MARK: Shared Instance
    var dataManager:DataManager
    static let sharedInstance : DataProvider = {
        let instance = DataProvider()
        return instance
    }()
    
    private override init() {
        dataManager = DataManager()
    }
    
    // Saves all quotes
    func saveQuotes(quote:[QuotesModel])  {
     dataManager.saveQuotes(Quotelist: quote)
    }
    
    // Fetch all quotes
    func fetchQuotes() -> [QuotesModel] {
        if let quotes =  dataManager.loadQuotes(){
        return quotes
        }
        return []
    }
    
    func saveLineItems(lineItems:[LineItemModel])  {
        
    }
    
    func fetchLineItems() -> [LineItemModel] {
        return [LineItemModel()]
    }
}
