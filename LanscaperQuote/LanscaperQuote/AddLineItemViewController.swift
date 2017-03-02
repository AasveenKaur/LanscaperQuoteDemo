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

class AddLineItemViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate, ContainerViewControllerDelegate, RectangleViewControllerDelegate, CircleViewControllerDelegate, TriangleViewControllerDelegate , PaverBlockCalculatorViewControllerDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    var delegate: AddLineItemViewControllerDelegate?
    var prevSHapeButton:UIButton?
    @IBOutlet weak var lineItemTypePicker: UITextField!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemDescriptionField: UITextView!
    @IBOutlet weak var quantityValue: UITextField!
    @IBOutlet weak var taxValue: UITextField!
    @IBOutlet weak var rateValue: UITextField!
    
    @IBOutlet weak var subHeader: UILabel!
    @IBOutlet var shapeButtons: [UIButton]!
    @IBOutlet weak var containerSubView: UIView!
    @IBOutlet weak var addTaxButton: UIButton!
    @IBOutlet var ItemSections: [UILabel]!
    @IBOutlet weak var totalValue: UILabel!
    
    
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
    
    
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DoneButtonPressed(_ sender: Any) {
        if let itemNameField =  itemNameField.text, let quantity = quantityValue.text , let rate =  rateValue.text , let tax = taxValue.text  {
            if((checkIfTextFieldHasText(textField: self.itemNameField)) && (checkIfTextFieldHasText(textField: quantityValue)) && (checkIfTextFieldHasText(textField: rateValue)))
            {
                delegate?.controller(controller: self, didSaveLineItemWithName: itemNameField, itemDescription: itemDescriptionField.text, itemQuantity: Float(quantity)!, itemPrice: Float(rate)!, itemTax: Float(tax)!)
                self.navigationController?.popToRootViewController(animated: true)
            }
                
            else{
                showAlert(readableErrorDescription: "Line item values missing", viewController: self)
            }
        }
    }
    
    
    @IBAction func TriangleButtonPressed(_ sender: UIButton) {
        //containerViewController?.swapFromViewControllers()
        if(prevSHapeButton != sender ){
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_TRIANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
            
            prevSHapeButton?.backgroundColor = UIColor.green
            
            prevSHapeButton = sender
            
            prevSHapeButton?.isSelected = true
        }
    }
    
    @IBAction func circleButtonPressed(_ sender: UIButton) {
        //containerViewController?.swapFromViewControllers()
        if(prevSHapeButton != sender ){
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_CIRCLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
            
            if(prevSHapeButton?.tag == 1){
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
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
            
            if(prevSHapeButton?.tag == 2){
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
        self.addDoneButtonOnKeyboard()
        self.taxValue.delegate =  self
        self.rateValue.delegate = self
        self.quantityValue.delegate = self
        self.lineItemTypePicker.delegate = self
        self.itemNameField.delegate = self
        self.itemDescriptionField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector((AddLineItemViewController).keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector((AddLineItemViewController).keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let pickerView = UIPickerView()
        prevSHapeButton = self.view.viewWithTag(1) as? UIButton
        prevSHapeButton?.backgroundColor = UIColor.red
        pickerView.delegate = self
        
        lineItemTypePicker.inputView = pickerView
        
        // Do any additional setup after loading the view.
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AddLineItemViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.quantityValue.inputAccessoryView = doneToolbar
        self.rateValue.inputAccessoryView = doneToolbar
        self.taxValue.inputAccessoryView = doneToolbar
        
    }
    func doneButtonAction()
    {
        self.quantityValue.resignFirstResponder()
        self.rateValue.resignFirstResponder()
        self.taxValue.resignFirstResponder()
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueContainerView" ){
            self.containerViewController = (segue.destination as! ContainerViewController)
            self.containerViewController?.delegate = self
        }
        
    }
    func showHiddenScreenForLineItemType(lineItemType:String)  {
        
        itemNameField.isHidden = false
        itemDescriptionField.isHidden = false
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
    
    func showHideBedPatterns(lineItemType:String){
        if (lineItemType == "Soil Calculator" || lineItemType == "Mulch Calculator" ){
            subHeader.isHidden = false
            for eachButton in shapeButtons{
                eachButton.isHidden = false
            }
        }else{
            subHeader.isHidden = true
            for eachButton in shapeButtons{
                eachButton.isHidden = true
            }
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
            showHideBedPatterns(lineItemType: lineItemTypePicker.text!)
            switch row {
                /*
                 ["0-Select calculator type","1-Paver Calculator", "2-Retaining Wall Calculator", "3-Soil Calculator", "4-Mulch Calculator", "5-Grass Seed Calculator", "6-Sod Calculator", "7-Plant and Flower Calculator" , " 8-Landscape Material Yardage Calculator" , "9-Acreage Calculator", "10-Other" ]
                 */
            case 1:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_PAVER_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant: 500)
                
            case 2:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_PAVER_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant: 500)
                
            case 3:
                setContainerViewForBedPattern()
                updateContainerViewHeightWith(myConstant: 300)
                
            case 4:
                setContainerViewForBedPattern()
                updateContainerViewHeightWith(myConstant: 300)
                
            case 5:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_GRASS_SEED_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant: 500)
                
            case 6:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant:300)
            case 7:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant:300)
            case 8:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant:300)
            case 9:
                containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
                updateContainerViewHeightWith(myConstant:300)
            case 10:
                containerSubView.isHidden = true
                updateContainerViewHeightWith(myConstant:0)
                
            default:
                print("hi")
            }
            
        }
        
    }
    
    func updateContainerViewHeightWith(myConstant:Float )  {
        self.containerViewHeight.constant = CGFloat(myConstant)
        self.view.layoutIfNeeded()
    }
    func setContainerViewForBedPattern()   {
        if (prevSHapeButton?.tag == 2) {
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_CIRCLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
            
        }else if(prevSHapeButton?.tag == 3){
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_TRIANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
            
        }else{
            containerViewController?.showViewWithSegue(segueIdentifier: EMPTY_SEGUE_RECTANGLE_IDENTIFIER,calculatorType: lineItemTypePicker.text!)
            
        }
    }
    //MARK:-CALCULATION DELEGATES
    
    
    func didCalculatePaverOrBlock(controller: PaverBlockCalculatorViewController, paverOrBlock: Float) {
        quantityValue.text = "\(paverOrBlock)"
    }
    
    
    
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
    
    
    func hideKeyboard() {
        if (self.lineItemTypePicker.isFirstResponder) {
            self.lineItemTypePicker.resignFirstResponder()
        } else if (self.itemNameField.isFirstResponder) {
            self.itemNameField.resignFirstResponder()
        }else if(self.itemDescriptionField.isFirstResponder) {
            self.itemDescriptionField.resignFirstResponder()
        }else if(self.quantityValue.isFirstResponder) {
            self.quantityValue.resignFirstResponder()
        }else if(self.taxValue.isFirstResponder) {
            self.taxValue.resignFirstResponder()
        }else if(self.rateValue.isFirstResponder) {
            self.rateValue.resignFirstResponder()
        }
        
    }
    
    //MARK: - Text field handlers
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text == textField.placeholder){
            textField.text = ""
        }
        activeField = textField
    }
    
    func checkIfTextFieldHasText(textField:UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty
        {
            //return true if it's not empty
            return true
        }
        return false
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    
                    if view.frame.origin.y == 0{
                        self.view.frame.origin.y -= keyboardSize.height
                    }
                }
                
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }}
        
        
        //self.view.endEditing(true)
        //self.scrollView.isScrollEnabled = true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Line Item Description"){
            textView.text = ""
        }
    }
    
    
    
    
}
