//
//  InvoiceTableViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/25/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
import CoreData

class InvoiceTableViewController: UITableViewController , NSFetchedResultsControllerDelegate{
    var myManagedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Quote> = {
        
        
        let fetchedResultsController = DataProvider.sharedInstance.coreDataManager.invoiceFetchViewCOntroller()
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    var selectedInvoice = QuotesModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        print("done")
        
        self.tableView.backgroundView = UIImageView.init(image:UIImage(named:"background" ))
        self.tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Invoices", image: UIImage(named: "dollar-sign.png"), tag: 0)
        myManagedObjectContext = DataProvider.sharedInstance.coreDataManager.managedObjectContext
        print(myManagedObjectContext)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "InvoiceCellID")! as! InvoiceTableViewCell
        
        // Configure Table View Cell
        configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor(red: 0.04, green: 0.16, blue: 0.35, alpha: 1.0)
        }
        
        
        return cell
    }
 
    func configureCell(cell: InvoiceTableViewCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let record = fetchedResultsController.object(at: indexPath as IndexPath)
        
        // Update Cell
        if let num = record.value(forKey: "estimateNumber") as? String {
            cell.invoiceNumber.text = num
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
            cell.invoiceTotal.text = "\(total)"
        }
        
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
                let cell = tableView.cellForRow(at: indexPath as IndexPath)
                configureCell(cell: cell! as! InvoiceTableViewCell, atIndexPath: indexPath as NSIndexPath)
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
