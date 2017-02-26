//
//  AddQuoteViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/30/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol AddQuoteViewControllerDelegate {
    
func controller(controller: AddQuoteViewController, didSaveQuoteWithClientName client: ClientModel, lineItemsList lineItems: [LineItemModel], totalCost total:Float, additonalInformation notes:String)
    
   
}
class AddQuoteViewController: UITableViewController,AddLineItemViewControllerDelegate ,ClientModalViewControllerDelegate{
    
    var delegate: AddQuoteViewControllerDelegate?
    var LineItems:Array = [LineItemModel]()
    var client:Array  = [ClientModel]()
    var note:Array = ["NOTES"]
    
    var discountValue:Float = 0.0
    var subTotalValue: Float = 0.0
    var  taxValue:  Float = 0.0
    var totalValue:Float = 0.0
    //    @IBOutlet weak var noteSummary: UILabel!l
    //    @IBOutlet weak var clientSignatureNeeded: UISwitch!
    //
    //    @IBOutlet weak var estimaeNumber: UITextField!
    //    @IBOutlet weak var mySignatureNeeded: UISwitch!
    //    @IBOutlet weak var dateValue: UILabel!
    //    @IBOutlet weak var poNumberValue: UITextField!
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        
      let demoClient = ClientModel(name: "JAZZ")
        // Notify Delegate
        delegate?.controller(controller: self, didSaveQuoteWithClientName: client[0], lineItemsList: LineItems, totalCost: totalValue, additonalInformation: note[0])
        
    
    
        // Dismiss View Controller
        dismiss(animated: true) {
            
        }
        //self.navigationController?.popViewController(animated: true)
    }
    
    //
    //    @IBAction func clientSignatureStateChanged(_ sender: Any) {
    //    }
    //
    //    @IBAction func mySignatureStateChanged(_ sender: Any) {
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView.init(image:UIImage(named:"background" ))
        self.tableView.separatorStyle = .none
        self.tableView.allowsMultipleSelectionDuringEditing = false
        //LineItems.append(LineItemModel())
        //client.append(ClientModel())
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            if(client.count == 0){
                return 1
            }
            else{
                return client.count
            }
        }
        else if(section == 1){
            return (LineItems.count)+2
            
        }
        else {
            return (note.count)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1){
            if(indexPath.row == LineItems.count+1 ){
                return 150.0
            }
        }
        return 55.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            if(client.count == 0){
                let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "StaticAddCustomerCellID")!
                return cell
            }
            else{
                let cell:ClientTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCellID")! as! ClientTableViewCell
                cell.customer.text = client[0].name
                return cell
            }
            
        }
        else if(indexPath.section == 1){
            
            
            if(indexPath.row == LineItems.count+1 ){
                let cell:SubTotalTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "SubTotalTableViewCellID")! as! SubTotalTableViewCell
                //set the data here
                return cell
            }
            else if(indexPath.row < LineItems.count){
                let cell:LineItemTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LineItemTableViewCellID")! as! LineItemTableViewCell
                cell.lineItem.text = LineItems[(indexPath.row)].name
                cell.lineItemTotal.text =  "$\(LineItems[(indexPath.row)].quantity*LineItems[(indexPath.row)].price)"
                //set the data here
                return cell
            }
            else{
                //Static cell
                let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "StaticAddLineItemsCellID")!
                return cell
            }
            
        }
        else {
            
            let cell:NotesTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCellID")! as! NotesTableViewCell
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 1){
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "SectionHeaderTableViewCellID")!
            let col3 = UIColor(red: 0.04, green: 0.16, blue: 0.35, alpha: 1.0)
            
           cell.contentView.backgroundColor = col3
            return cell.contentView
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SegueToAddClientModalVC"){
        let vc = segue.destination as! ClientModalViewController
        vc.delegate = self
        }
    }
    
    
    func controller(controller: AddLineItemViewController, didSaveLineItemWithName name: String, itemDescription description: String, itemQuantity quantity: Float, itemPrice rate: Float, itemTax tax: Float) {
        tableView.beginUpdates()
        let lineItem = LineItemModel( name: name, lineItemdescription: description, quantity: quantity, price: rate, tax: tax)
        self.LineItems.append(lineItem)
        
        tableView.insertRows(at: [NSIndexPath.init(row: LineItems.count-1, section: 1) as IndexPath], with: .left)
        
        tableView.endUpdates()
        subTotalValue += quantity*rate
        taxValue = tax
        totalValue = (((tax+100)/100)*subTotalValue)
        // I wanted to update this cell specifically
        let indexPathForSubTotalTableViewCell = IndexPath(row: LineItems.count+1 , section: 1)
        let SubTotalCell = tableView.cellForRow(at: indexPathForSubTotalTableViewCell) as! SubTotalTableViewCell
        SubTotalCell.subTotalValue.text = "$\(self.subTotalValue)"
        SubTotalCell.taxValue.text = "\(self.taxValue)%"
        SubTotalCell.totalValue.text = "$\(self.totalValue)"
    }
    
    func controller(controller: ClientModalViewController, didSaveClientWithName name: String, phoneNumber phoneNo: String, emailAddress email: String) {
        tableView.beginUpdates()
        self.client.append(ClientModel(name: name, email: email, phoneOne: phoneNo))
        // I wanted to update this cell specifically
        let ClientCell = IndexPath(row: client.count-1, section: 0)
        tableView.reloadRows(at: [ClientCell], with: .none)
        tableView.endUpdates()
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
    
    
}
