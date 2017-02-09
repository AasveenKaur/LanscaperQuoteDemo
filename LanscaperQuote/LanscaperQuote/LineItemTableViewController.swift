//
//  LineItemTableViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/5/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class LineItemTableViewController: UITableViewController {
 var LineItemslist = [LineItemModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.tableView.backgroundView = UIImageView.init(image:UIImage(named:"background" ))
        self.tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let Quotelist = DataProvider.sharedInstance.fetchQuotes()
        for eachQuote in Quotelist{
            for eachLineItem in  eachQuote.LineItems!{
                LineItemslist.append(eachLineItem)
            }
        }
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SegueToLineItemTypePage"){
            let destinationVC = segue.destination as! AddLineItemViewController
            destinationVC.delegate = self.navigationController?.viewControllers[0] as! AddQuoteViewController?
         
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LineItemslist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineItemsCellID", for: indexPath)
        cell.textLabel?.text = LineItemslist[indexPath.row].name
        cell.detailTextLabel?.text = LineItemslist[indexPath.row].lineItemdescription
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor(red: 0.04, green: 0.16, blue: 0.35, alpha: 1.0)
        }
        // Configure the cell...

        return cell
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
