//
//  CoreDataManager.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/23/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "LandscaperQuote", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    fileprivate var _managedObjectContext: NSManagedObjectContext?
    
    func initializedManagedObjectContext() -> NSManagedObjectContext {
        let coordinator = self.persistentStoreCoordinator
        let newMOC = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        newMOC.persistentStoreCoordinator = coordinator
        return newMOC
    }
    var managedObjectContext: NSManagedObjectContext {
        get {
            if _managedObjectContext != nil {
                return _managedObjectContext!
            }
            _managedObjectContext = initializedManagedObjectContext()
            return _managedObjectContext!
        }
    }
    
    fileprivate var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        get {
            if _persistentStoreCoordinator != nil {
                return _persistentStoreCoordinator!
            }
            _persistentStoreCoordinator = initializedPersistentStoreCoordinator()
            return _persistentStoreCoordinator!
        }
    }
    
    func initializedPersistentStoreCoordinator () -> NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: datastoreURL(), options: nil)
        }
        catch {
            // Report any error we got.
            let failureReason = "There was an error creating or loading the application's saved data."
            
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            
            abort()
        }
        
        return coordinator
    }
    
    func datastoreURL() -> URL {
        let datastoreName = "Quotes.sqlite"
        print ("open \(applicationDocumentsDirectory.path)")
        
        let resultURL = self.applicationDocumentsDirectory.appendingPathComponent(datastoreName)
        return resultURL
    }
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    func save () {
        try! managedObjectContext.save()
        
    }
    
  
    func saveQuote(quote:QuotesModel)  {
       let v = Quote.findOrCreateQuote(self.managedObjectContext, quoteModel: quote)
        print("aasveen->\(v.date)")
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
   
  
    func show()  {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Quote", in: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try self.managedObjectContext.fetch(fetchRequest)
            let count = try  self.managedObjectContext.count(for: fetchRequest)
            print(result)
            print("count\(count)")
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
       
    }
    
    func quoteFetchViewCOntroller()  -> NSFetchedResultsController<Quote> {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quote")
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "estimateNumber", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController as! NSFetchedResultsController<Quote>
    }
    
    func lineItemFetchViewCOntroller()  -> NSFetchedResultsController<LineItem> {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LineItem")
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "itemName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController as! NSFetchedResultsController<LineItem>
    }
    
    func clientFetchViewCOntroller()  -> NSFetchedResultsController<Client> {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController as! NSFetchedResultsController<Client>
    }


    func invoiceFetchViewCOntroller() -> NSFetchedResultsController<Quote> {
        let fetchRequest = managedObjectModel.fetchRequestFromTemplate(withName: "quoteWithInvoiceStatusTrue",substitutionVariables: ["status": true])
       
       let sortDescriptor = NSSortDescriptor(key: "estimateNumber", ascending: true)
        fetchRequest?.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest!, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
      return fetchedResultsController as! NSFetchedResultsController<Quote>

        
    }

    func deleteQuote(quote:Quote)  {
        
        
        self.managedObjectContext.delete(quote)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }

    func updateQuoteInvoiceStatus(quote:Quote, status:Bool)  {
    
    quote.invoiceStatus = status
   
    do {
        try self.managedObjectContext.save()
    } catch {
        let saveError = error as NSError
        print(saveError)
    }
}

    
}
