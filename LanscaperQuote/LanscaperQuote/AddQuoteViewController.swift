//
//  AddQuoteViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/30/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol AddQuoteViewControllerDelegate {
    func controller(controller: AddQuoteViewController, didSaveItemWithEstimaeNumber estimaeNumber: String, andTotal totalValue: Float)
}
class AddQuoteViewController: UITableViewController {

    var delegate: AddQuoteViewControllerDelegate?
    @IBOutlet weak var discountTextField: UITextField!
    
    @IBOutlet weak var subTotalValue: UILabel!
    
    @IBOutlet weak var taxValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var noteSummary: UILabel!
    @IBOutlet weak var clientSignatureNeeded: UISwitch!
    
    @IBOutlet weak var estimaeNumber: UITextField!
    @IBOutlet weak var mySignatureNeeded: UISwitch!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var poNumberValue: UITextField!
   
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
      //  if let estimaeNumber = estimaeNumber.text, let totalValue = totalValue.text, let total = Float(totalValue) {
            // Notify Delegate
           
            delegate?.controller(controller: self, didSaveItemWithEstimaeNumber: "5", andTotal: 10.0)
            
            // Dismiss View Controller
        dismiss(animated: true) { 
            
        }
        //self.navigationController?.popViewController(animated: true)
        }
   
    
    @IBAction func clientSignatureStateChanged(_ sender: Any) {
    }
        
    @IBAction func mySignatureStateChanged(_ sender: Any) {
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
