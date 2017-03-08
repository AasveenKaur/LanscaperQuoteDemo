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
    var coreDataManager:CoreDataManager
    static let sharedInstance : DataProvider = {
        let instance = DataProvider()
        return instance
    }()
    
    private override init() {
        dataManager = DataManager()
        coreDataManager = CoreDataManager()
    }
    
    // Saves all quotes
    func saveQuotes(quote:[QuotesModel])  {
     dataManager.saveQuotes(Quotelist: quote)
        
    }
    
    func saveAQuote(quote:QuotesModel)  {
      coreDataManager.saveQuote(quote:quote)
      coreDataManager.show()
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
    
    func showIt()  {
        coreDataManager.show()
    }

func deleteQuote(quote:Quote){
  coreDataManager.deleteQuote(quote: quote)
}

    
    func  updateQuoteInvoiceStatus(quote:Quote, status:Bool){
    coreDataManager.updateQuoteInvoiceStatus(quote: quote, status: status)
    }
    
    
    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImage(){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("apple.jpg")
        if fileManager.fileExists(atPath: imagePAth){
           // self.imageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }
    
}
