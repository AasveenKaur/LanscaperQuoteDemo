//
//  ClientTableViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/25/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
import CoreData

class ClientTableViewController: UITableViewController , NSFetchedResultsControllerDelegate,AddQuoteViewControllerDelegate {
    var myManagedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Client> = {
        
        
        let fetchedResultsController = DataProvider.sharedInstance.coreDataManager.clientFetchViewCOntroller()
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
      var selectedClient = Client()
    
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
        tabBarItem = UITabBarItem(title: "Clients", image: UIImage(named: "man.png"), tag: 0)
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
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ClientTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCellIDTwo")! as! ClientTableViewCell
        
        // Configure the cell...
        // Configure Table View Cell
        configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
        
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor(red: 0.04, green: 0.16, blue: 0.35, alpha: 1.0)
        }


        return cell
    }
    
    func configureCell(cell: ClientTableViewCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let record = fetchedResultsController.object(at: indexPath as IndexPath)
        
        // Update Cell
        if let name = record.value(forKey: "name") as? String {
            
            cell.customer.text =  name
        }
//        if let email = record.value(forKey: "email") as? String {
//            cell.detailTextLabel?.text = email
//        }
        
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
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! ClientTableViewCell
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

    func controller(controller: AddQuoteViewController, didSaveQuoteWithClientName client: ClientModel, lineItemsList lineItems: [LineItemModel], totalCost total: Float, additonalInformation notes: String, discount: Float) {
        // self.tableView.beginUpdates()
        let newEstimateNUmber = estimateNumberGenerator
        let quote =  QuotesModel( estimateNumber: "\(newEstimateNUmber)", client: client, LineItems: lineItems, totalAmount: total, notes: notes, discount: discount)
        estimateNumberGenerator += 1
        DataProvider.sharedInstance.saveAQuote(quote: quote)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedClient = self.fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "segueToAddQuoteFromClientTable", sender: nil)

    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! UINavigationController;
        let vc =   destination.topViewController as! AddQuoteViewController
        vc.delegate = self
        let name = selectedClient.value(forKey:"name" )!
        let email = selectedClient.value(forKey:"email" )!
        let phone = selectedClient.value(forKey:"phoneOne" )!
        let model = ClientModel( name:name as! String , email: email as! String, phoneOne: phone as! String)
        vc.client = [model]
      
        
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

    

}
