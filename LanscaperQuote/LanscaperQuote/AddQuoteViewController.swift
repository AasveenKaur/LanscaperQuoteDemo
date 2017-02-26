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
class AddQuoteViewController: UITableViewController,AddLineItemViewControllerDelegate ,ClientModalViewControllerDelegate,showLineItemViewControllerDelegate{
    var selectedLineItem:LineItemModel!
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
        return 52.0
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(indexPath.section == 0){
            if(!(client.count == 0)){
                return true
            }
        }
        if(indexPath.section == 1){
            if((indexPath.row < LineItems.count )){
                return true
            }
        }
        return false
       
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
    
            tableView.beginUpdates()
            self.LineItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
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
        if(segue.identifier == "SegueToEditClientModalVC"){
            let vc = segue.destination as! ClientModalViewController
            vc.delegate = self
            vc.client = self.client[0]
        }
        if(segue.identifier == "SegueToShowLineItem"){
            let vc = segue.destination as! showLineItemViewController
            vc.delegate = self
            vc.lineItem = selectedLineItem
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
    
    func controller(controller: showLineItemViewController, didEditLineItemWithName name: String, itemDescription description: String, itemQuantity quantity: Float, itemPrice rate: Float, itemTax tax: Float) {
        tableView.beginUpdates()
        let lineItem = LineItemModel( name: name, lineItemdescription: description, quantity: quantity, price: rate, tax: tax)
        if let index = self.LineItems.index(of:selectedLineItem) {
            //delete previous one
            self.LineItems.remove(at: index)
            self.LineItems.insert(lineItem, at: index)
            tableView.reloadRows(at: [NSIndexPath.init(row: index, section: 1) as IndexPath], with: .fade)
            subTotalValue -= (self.LineItems[index].quantity*self.LineItems[index].price)
        }
        //red-add or edit
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
        if(self.client.count > 0){
            self.client.removeAll()
        }
        self.client.append(ClientModel(name: name, email: email, phoneOne: phoneNo))
        // I wanted to update this cell specifically
        let ClientCell = IndexPath(row: client.count-1, section: 0)
        tableView.reloadRows(at: [ClientCell], with: .none)
        tableView.endUpdates()
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if(cell is LineItemTableViewCell ){
            selectedLineItem = self.LineItems[indexPath.row]
            performSegue(withIdentifier: "SegueToShowLineItem", sender: self)
        }
        
        
    }
    
}
