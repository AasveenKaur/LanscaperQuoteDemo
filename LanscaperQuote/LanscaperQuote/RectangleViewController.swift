//
//  RectangleViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

protocol RectangleViewControllerDelegate {
    func controller(controller: RectangleViewController, didCalculateMulchQuantity mulch:Float, forBag bagVolume: Float)
}

class RectangleViewController: BaseViewController {
   
    var calculatorType:String = ""
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var bedDepth: UITextField!
    @IBOutlet weak var bedDepthLabel: UILabel!
    @IBOutlet weak var bedLength: UITextField!
    @IBOutlet weak var bedWidth: UITextField!
    var delegate: RectangleViewControllerDelegate?
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        
        if(checkIfTextFieldHasText(textField:bedLength) &&
            checkIfTextFieldHasText(textField:bedWidth)){
            
            if(checkIfTextFieldHasText(textField:bedDepth)){
                if(calculatorType == "Mulch Calculator"){
                    let volume = calculateVolume()
                    result.text = "You will need approximately \(volume) cubic yards of mulch"
                }else if(calculatorType == "Plant and Flower Calculator"){
                    
                    result.text = "You will need approximately \(Int(calculatePlants())) plants."
                }
                else if(calculatorType == "Soil Calculator"){
                    let volume = calculateVolume()
                    result.text = "You will need approximately \(volume) cubic yards of soil"
                }
                else if(calculatorType == "Landscape Material Yardage Calculator"){
                    result.text = "You will need approximately \(calculateYardage()) cubic yards of material."
                }
                result.isHidden = false
            }else{
                if(calculatorType == "Acreage Calculator"){
                    result.text = "You will need approximately \(calculateAcreage()) Acreage."
                    result.isHidden = false
                }
                else{
                    showAlert(readableErrorDescription: "Please enter all the values for calculation.", viewController:self )
                }
            }
            
           
            
        }else{
            showAlert(readableErrorDescription: "Please enter all the values for calculation.", viewController:self )
        }
    }
    
    func calculateAcreage() -> Float {
        if  let length = Float(bedLength.text!), let width = Float(bedWidth.text!){
            let acre =  convertSquareFeetToAcreWith(area: (length*width))
           
        delegate?.controller(controller: self, didCalculateMulchQuantity: roundOffToTwoDecimalPlacesWith(quantity:acre ) , forBag: 100)
            return roundOffToTwoDecimalPlacesWith(quantity:acre)
        }
        return 0.0
    }
    
    func calculateYardage() -> Float {
         if let depth = Float(bedDepth.text!), let length = Float(bedLength.text!), let width = Float(bedWidth.text!){
            delegate?.controller(controller: self, didCalculateMulchQuantity: roundOffToTwoDecimalPlacesWith(quantity:convertCubicFeetToCubicYardWith(volume:(depth*length*width))), forBag: 100)
        return roundOffToTwoDecimalPlacesWith(quantity:convertCubicFeetToCubicYardWith(volume:(depth*length*width)))
        
        }
        return 0.0
    }
    
    func calculatePlants() -> Float{
        if let bedWidth = bedWidth.text?.floatValue, let bedLength = bedLength.text?.floatValue, let plantSpacing = bedDepth.text?.floatValue{
        let row = feetToInch(feet:bedLength)/plantSpacing
        let column = feetToInch(feet:bedWidth)/plantSpacing
            delegate?.controller(controller: self, didCalculateMulchQuantity: ceil(row*column), forBag: 100)
            return ceil(row*column)
            
            
            
        }
        return 0.0
    }
    
    func calculateVolume() -> Float {
        var volume:Float = 0.0
        if let depth = Float(bedDepth.text!), let length = Float(bedLength.text!), let width = Float(bedWidth.text!){
           volume = calculateSoilOrMulchVolumeforRectangularPatternWith(length: length, withWidth: width, withDepth: depth)
             delegate?.controller(controller: self, didCalculateMulchQuantity: volume, forBag: 100)
            }
        else{
            print("ERROR IN INPUT")
        }
      return volume
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bedLength.delegate = self
        bedWidth.delegate = self
        bedDepth.delegate = self
        bedLength.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        bedWidth.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        bedDepth.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        if(calculatorType == pickOption[6] || calculatorType == pickOption[9]){
            bedDepth.isHidden = true
            bedDepthLabel.isHidden = true
        } else if(calculatorType == pickOption[7]){
            bedDepthLabel.text = "Plant Spacing (in inches)"
        }else if (calculatorType == pickOption[8]){
            bedDepthLabel.text = "Bed height (in feet)"
        }
        
        // Do any additional setup after loading the view.
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
       func doneButtonAction()
    {
        self.bedLength.resignFirstResponder()
        self.bedDepth.resignFirstResponder()
        self.bedWidth.resignFirstResponder()
    }
    
    
    

}
