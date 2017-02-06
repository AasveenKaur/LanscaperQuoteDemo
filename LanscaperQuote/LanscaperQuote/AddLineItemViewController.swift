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

class AddLineItemViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate, ContainerViewControllerDelegate, RectangleViewControllerDelegate, CircleViewControllerDelegate {
    var prevSHapeButton:UIButton?
     @IBOutlet weak var lineItemTypePicker: UITextField!
    
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemDescriptionField: UITextView!
    @IBOutlet var shapeButtons: [UIButton]!
    @IBOutlet weak var containerSubView: UIView!
    @IBOutlet weak var addTaxButton: UIButton!
    @IBOutlet var ItemSections: [UILabel]!
    
    @IBOutlet weak var quantityValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var taxValue: UILabel!
    @IBOutlet weak var rateValue: UILabel!
    
    var containerViewController:ContainerViewController?
    
    
   
    
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
        if(lineItemType == "Mulch Calculator" || lineItemType == "Soil Calculator"){
            itemNameField.isHidden = false
            
            itemDescriptionField.isHidden = false
            for eachButton in shapeButtons{
                eachButton.isHidden = false
            }
            containerSubView.isHidden = false
            addTaxButton.isHidden = false
            for eachSection in  ItemSections{
                eachSection.isHidden = false
            }
            quantityValue.isHidden = false
            rateValue.isHidden = false
            totalValue.isHidden = false
            taxValue.isHidden = false
        }
     
        
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
        }
       
    
    }
    //MARK:-CALCULATION DELEGATES
    func controller(controller: RectangleViewController, didCalculateMulchQuantity mulch: Float, forBag bagVolume: Float) {
        print("hundal-->\(mulch)")
    }
    
    func controller(controller: CircleViewController, didCalculateArea area:Float){
         print("kaur-->\(area)")
    }

}
