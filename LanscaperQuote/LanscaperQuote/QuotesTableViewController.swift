//
//  QuotesTableViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/28/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class QuotesTableViewController: BaseTableViewController,AddQuoteViewControllerDelegate {
 var Quotelist = [QuotesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
     print(Quotelist)
        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       Quotelist = DataProvider.sharedInstance.FetchQuotes() 
    }
    
   
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Quotelist.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let ob = self.Quotelist[indexPath.row]  
        cell.textLabel?.text = ob.estimateNumber
        
        return cell
    }
    
    func controller(controller: AddQuoteViewController, didSaveItemWithEstimaeNumber estimaeNumber: String, andTotal totalValue: Float)  { // Create Item
      self.tableView.beginUpdates()
      
        let quote = QuotesModel(quoteID: estimaeNumber, estimateNumber: estimaeNumber, totalAmount: totalValue)
       
        // Add Item to Items
        Quotelist.append(quote)
        
        // Add Row to Table View
        //tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: (Quotelist.count - 1), inSection: 0)], withRowAnimation: .None)
        tableView.insertRows(at: [NSIndexPath.init(row: Quotelist.count-1, section: 0) as IndexPath], with: .left)
        //tableView.reloadData()
        self.tableView.endUpdates()
        // Save Items
        DataProvider.sharedInstance.saveQuotes(quote: Quotelist)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueToAddQuoteVC"){
        //let destination = segue.destination as! UINavigationController;
       // let vc =   destination.topViewController as! AddQuoteViewController
         //   vc.delegate = self
           
       // print(vc)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
