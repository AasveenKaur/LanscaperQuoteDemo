//
//  showLineItemViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/26/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

protocol showLineItemViewControllerDelegate {
    
    func controller(controller: showLineItemViewController, didEditLineItemWithName name:String, itemDescription description: String, itemQuantity quantity:Float, itemPrice rate:Float, itemTax tax:Float )
    
    
}

class showLineItemViewController: UIViewController {
    
   
    @IBOutlet weak var itemName: UITextField!
    
    
    @IBOutlet weak var itemDescription: UITextView!
    
    
    @IBOutlet weak var quantity: UITextField!
    
    
    @IBOutlet weak var rate: UITextField!
  
    @IBOutlet weak var tax: UITextField!
    
    @IBOutlet weak var total: UITextField!
    
    @IBAction func editLineItem(_ sender: Any) {
        
        if((checkIfTextFieldHasText(textField: self.itemName)) && (checkIfTextFieldHasText(textField: quantity)) && (checkIfTextFieldHasText(textField: rate)))
        {
            delegate?.controller(controller: self, didEditLineItemWithName: self.itemName.text!, itemDescription: itemDescription.text, itemQuantity: Float(quantity.text!)!, itemPrice: Float(rate.text!)!, itemTax: Float(tax.text!)!)
            dismiss(animated: true, completion: nil)
        }
        else{
            showAlert(readableErrorDescription: "Line item values missing", viewController: self)
        }
        
        
    }
    
var delegate: showLineItemViewControllerDelegate?
    var lineItem:LineItemModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if lineItem != nil{
            self.itemName.text = lineItem?.name
            self.itemDescription.text = lineItem?.lineItemdescription
            if let quantity = lineItem?.quantity, let rate = lineItem?.price, let tax = lineItem?.tax{
                self.quantity.text = "\(quantity)"
            

            self.rate.text = "\(rate)"

            self.tax.text = "\(tax)"

            self.total.text = "\(Float((rate))*Float((quantity))*((Float(tax)+100)/100))"
            }

        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
