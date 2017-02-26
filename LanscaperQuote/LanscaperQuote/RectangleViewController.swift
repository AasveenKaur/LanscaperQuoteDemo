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
        let volume = calculateVolume()
        delegate?.controller(controller: self, didCalculateMulchQuantity: volume, forBag: 100)
        if(calculatorType == "Mulch Calculator"){
        result.text = "You will need approximately \(volume) cubic yards of mulch"
        }else if(calculatorType == "Soil Calculator"){
            result.text = "You will need approximately \(volume) cubic yards of soil"
        }
        result.isHidden = false
            
    }
    
    func calculateVolume() -> Float {
        var volume:Float = 0.0
        if let depth = Float(bedDepth.text!), let length = Float(bedLength.text!), let width = Float(bedWidth.text!){
           volume = calculateSoilOrMulchVolumeforRectangularPatternWith(length: length, withWidth: width, withDepth: depth)
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
            bedDepthLabel.text = "Plant Spacing(in inches)"
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
