//
//  QuotesTableViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/28/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
import CoreData

class QuotesTableViewController: BaseTableViewController,AddQuoteViewControllerDelegate, NSFetchedResultsControllerDelegate {
    
    var myManagedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Quote> = {
        
        
        let fetchedResultsController = DataProvider.sharedInstance.coreDataManager.quoteFetchViewCOntroller()
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController 
    }()
    var selectedQuote:Quote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("jatti\(calculateTaxOn(amount: 100,taxPercentage: 12.8))")
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        print("done")
     DataProvider.sharedInstance.showIt()
        
        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     //  Quotelist = DataProvider.sharedInstance.fetchQuotes()
        myManagedObjectContext = DataProvider.sharedInstance.coreDataManager.managedObjectContext
        print(myManagedObjectContext)
    }
    
   
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
       
        let cell:QuoteTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCellID")! as! QuoteTableViewCell
        
        // Configure Table View Cell
        configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor(red: 0.04, green: 0.16, blue: 0.35, alpha: 1.0)
        }
        
        
        return cell
    }
    
    func configureCell(cell: QuoteTableViewCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let record = fetchedResultsController.object(at: indexPath as IndexPath)
        
        // Update Cell
        if let num = record.value(forKey: "estimateNumber") as? String {
            cell.quoteNumber.text = num
        }
        if let client = record.value(forKey: "client") as? Client {
            cell.clientName.text = client.name
        }
        
        if let lineItems = record.value(forKey:"lineItems") as? Set<LineItem>{
            for l in lineItems{
               print("LineItem->\( l.itemName)")
                print("LineItem->\( l.itemDescription)")
            }
            print("-------")
        }
        
        if let total = record.value(forKey: "totalAmount") as? Float {
            cell.quoteTotal.text = "\(total)"
        }
        
    }
    

    
    func controller(controller: AddQuoteViewController, didSaveQuoteWithClientName client: ClientModel, lineItemsList lineItems: [LineItemModel], totalCost total: Float, additonalInformation notes: String) {
        
        
        // self.tableView.beginUpdates()
        let newEstimateNUmber = estimateNumberGenerator
        let quote =  QuotesModel( estimateNumber: "\(newEstimateNUmber)", client: client, LineItems: lineItems, totalAmount: total, notes: notes)
        estimateNumberGenerator += 1
        DataProvider.sharedInstance.saveAQuote(quote: quote)
        
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueToAddQuoteVC"){
        let destination = segue.destination as! UINavigationController;
        let vc =   destination.topViewController as! AddQuoteViewController
        vc.delegate = self
        }
        else if (segue.identifier == "segueToPreviewVC"){
            let destination = segue.destination as! PreviewViewController;
            destination.quoteDetails = selectedQuote
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Fetch Record
        let record = fetchedResultsController.object(at: indexPath as IndexPath)
        selectedQuote = record
        performSegue(withIdentifier: "segueToPreviewVC", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
    
    // MARK: Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
   
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath as IndexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! QuoteTableViewCell
                configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .fade)
            }
            break;
        }
    }
    

    

}
