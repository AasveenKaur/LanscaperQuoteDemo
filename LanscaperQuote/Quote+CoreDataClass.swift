//
//  Quote+CoreDataClass.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/24/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import CoreData

@objc(Quote)
public class Quote: NSManagedObject {

    
    class func findOrCreateQuote(_ moc: NSManagedObjectContext, quoteModel: QuotesModel) -> Quote {
        
        let quoteID = quoteModel.quoteID
        let existingQuote = quotes(moc, quoteID: quoteID)
        if existingQuote.count == 1 {
            return existingQuote[0] as! Quote
        }
        let newQuote = NSEntityDescription.insertNewObject(forEntityName: "Quote", into: moc) as! Quote
        newQuote.quoteID = quoteModel.quoteID
        newQuote.totalAmount = quoteModel.totalAmount!
        newQuote.contractStatement = quoteModel.contractStatement
        newQuote.date = quoteModel.date
        newQuote.estimateNumber = quoteModel.estimateNumber
        newQuote.invoiceStatus = quoteModel.invoiceStatus
        newQuote.note = quoteModel.notes
        newQuote.poNumber = quoteModel.poNumber
        newQuote.sentToClient = quoteModel.sentToClient
        newQuote.discount = quoteModel.discount!
        
        let newClient = Client.createClient(moc, clientModel: quoteModel.client)
        newQuote.client = newClient
        for eachLineitem in quoteModel.LineItems!{
            newQuote.addToLineItems(LineItem.createLineItem(moc, lineItemModel: eachLineitem))
        }
        
        return newQuote
    }
    
    class func quotes(_ moc: NSManagedObjectContext, quoteID: String) -> NSArray {
        let model = moc.persistentStoreCoordinator?.managedObjectModel
        let request = model?.fetchRequestFromTemplate(withName: "quoteWithQuoteID",
                                                      substitutionVariables: ["whatever": quoteID])
        do {
            let result = try moc.fetch(request!)
            return result as NSArray
        }
        catch {
            print ("fetch", request!, "failed:", error)
            abort()
        }
    }

    
    
}
