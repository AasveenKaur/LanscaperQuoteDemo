//
//  AddLineItemViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
protocol AddLineItemViewControllerDelegate {
    func controller(controller: AddLineItemViewController, didSaveLineItemWithName name:String, itemDescription description: String, itemQuantity quantity:Float, itemPrice rate:Float, itemTax tax:Float )
}

class AddLineItemViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate, ContainerViewControllerDelegate, RectangleViewControllerDelegate, CircleViewControllerDelegate, TriangleViewControllerDelegate, UITextFieldDelegate {
    var delegate: AddLineItemViewControllerDelegate?
    var prevSHapeButton:UIButton?
     @IBOutlet weak var lineItemTypePicker: UITextField!
    
    @IBOutlet weak var subHeader: UILabel!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemDescriptionField: UITextView!
    @IBOutlet var shapeButtons: [UIButton]!
    @IBOutlet weak var containerSubView: UIView!
    @IBOutlet weak var addTaxButton: UIButton!
    @IBOutlet var ItemSections: [UILabel]!
    
    @IBOutlet weak var quantityValue: UITextField!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var taxValue: UITextField!
    @IBOutlet weak var rateValue: UITextField!
    
    var containerViewController:ContainerViewController?
    
   
    @IBAction func rateValueChanged(_ sender: UITextField) {
        if let rateText = sender.text, let quantityText = quantityValue.text{
        if let rate = Float(rateText), let quantity = Float(quantityText){
            totalValue.text = "$\(rate*quantity)"
        }
        }
        else{
            totalValue.text = "$0.0"
        }
        
    }
    
    @IBAction func taxValueChanged(_ sender: UITextField) {
        if let rateText = rateValue.text, let quantityText = quantityValue.text, let taxText = sender.text{
            if let rate = Float(rateText), let quantity = Float(quantityText), let tax = Float(taxText){
                totalValue.text = "$\(rate*quantity*((tax+100)/100))"
            }
        }else{
            totalValue.text = "$0.0"
        }

    }
    
   
    @IBAction func DoneButtonPressed(_ sender: Any) {
        delegate?.controller(controller: self, didSaveLineItemWithName: itemNameField.text!, itemDescription: itemDescriptionField.text, itemQuantity: Float(quantityValue.text!)!, itemPrice: Float(rateValue.text!)!, itemTax: Float(taxValue.text!)!)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func TriangleButtonPressed(_ sender: UIButton) {
        //containerViewController?.swapFromViewControllers()
        if(prevSHapeButton != sender ){
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_TRIANGLE_IDENTIFIER)
            prevSHapeButton?.backgroundColor = UIColor.green
          
            prevSHapeButton = sender
           
            prevSHapeButton?.isSelected = true
        }
          }
  
    @IBAction func circleButtonPressed(_ sender: UIButton) {
        //containerViewController?.swapFromViewControllers()
        if(prevSHapeButton != sender ){
        containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_CIRCLE_IDENTIFIER)
            if(prevSHapeButton == shapeButtons[0]){
            prevSHapeButton?.backgroundColor = UIColor.green
            }
            else{
                prevSHapeButton?.isSelected = false
            }
            prevSHapeButton = sender
            prevSHapeButton?.backgroundColor = UIColor.red
        }
    }
 
    
    @IBAction func rectangleButtonPressed(_ sender: UIButton) {
        //containerViewController?.swapFromViewControllers()
        if(prevSHapeButton != sender ){
        containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER)
             if(prevSHapeButton == shapeButtons[1]){
            prevSHapeButton?.backgroundColor = UIColor.green
             }else{
                prevSHapeButton?.isSelected = false
            }
            prevSHapeButton = sender
            prevSHapeButton?.backgroundColor = UIColor.red
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taxValue.delegate = self
        rateValue.delegate = self
        quantityValue.delegate = self
        
        let pickerView = UIPickerView()
        prevSHapeButton = shapeButtons[0]
        prevSHapeButton?.backgroundColor = UIColor.red
        pickerView.delegate = self
        
        lineItemTypePicker.inputView = pickerView

        // Do any additional setup after loading the view.
    }
    
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueContainerView" ){
            self.containerViewController = (segue.destination as! ContainerViewController)
            self.containerViewController?.delegate = self
        }
    }
    func showHiddenScreenForLineItemType(lineItemType:String)  {
        //if(lineItemType == "Mulch Calculator" || lineItemType == "Soil Calculator"){
            itemNameField.isHidden = false
            
            itemDescriptionField.isHidden = false
            for eachButton in shapeButtons{
                eachButton.isHidden = false
            }
            subHeader.isHidden = false
            containerSubView.isHidden = false
            addTaxButton.isHidden = false
            
            for eachSection in  ItemSections{
                eachSection.isHidden = false
            }
            quantityValue.isHidden = false
            rateValue.isHidden = false
            totalValue.isHidden = false
            taxValue.isHidden = false
        //}
     
        
    }
    
   
   //MARK:- Picker delegate functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        if(row != 0){
            
            lineItemTypePicker.text = pickOption[row]
            self.view.endEditing(true)
            showHiddenScreenForLineItemType(lineItemType: lineItemTypePicker.text!)
            if(row == 2){
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RETAINING_WALL_IDENTIFIER)
            }
        }
        

       
    
    }
    //MARK:-CALCULATION DELEGATES
    func controller(controller: RectangleViewController, didCalculateMulchQuantity mulch: Float, forBag bagVolume: Float) {
        print("hundal-->\(mulch)")
        quantityValue.text = "\(mulch)"
    }
    
    func controller(controller: CircleViewController, didCalculateArea area:Float){
         print("kaur-->\(area)")
        quantityValue.text = "\(area)"

    }
    func controller(controller: TriangleViewController, didCalculateTriangleMulchQuantity mulch: Float, forBag bagVolume: Float) {
        print("hundal-->\(mulch)")
        quantityValue.text = "\(mulch)"    }

}
