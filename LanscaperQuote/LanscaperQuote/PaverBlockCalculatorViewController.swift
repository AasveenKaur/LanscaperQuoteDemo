//
//  PaverBlockCalculatorViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/20/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

protocol PaverBlockCalculatorViewControllerDelegate {
    func didCalculatePaverOrBlock(controller: PaverBlockCalculatorViewController,  paverOrBlock:Float)
}

class PaverBlockCalculatorViewController: UIViewController {
    var calculatorType:String = ""

    @IBOutlet weak var patioOrWallWidth: UITextField!
    @IBOutlet weak var mainHeading: UILabel!
    @IBOutlet weak var subHeading: UILabel!
    @IBOutlet weak var patioOrWallength: UITextField!
    @IBOutlet weak var paverOrBlockWidth: UITextField!
    @IBOutlet weak var paverOrBlockLength: UITextField!
    @IBOutlet weak var result: UILabel!
    var delegate: PaverBlockCalculatorViewControllerDelegate?
    
    @IBAction func calculateResult(_ sender: Any) {
        if(checkIfTextFieldHasText(textField:patioOrWallWidth) &&
            checkIfTextFieldHasText(textField:patioOrWallength) &&
            checkIfTextFieldHasText(textField:paverOrBlockWidth) &&
            checkIfTextFieldHasText(textField:paverOrBlockLength)){
        if(calculatorType == "Paver Calculator"){
            calculatePavers()
            }
        else{
            calculateRetainingBlock()
            }
        }else{
            showAlert(readableErrorDescription: "Please enter all the values for calculation.", viewController:self )
        }
    }
    
    
    func calculateRetainingBlock()  {
        if let wallWidth = patioOrWallWidth.text?.floatValue, let wallLength = patioOrWallength.text?.floatValue, let blockWidth = paverOrBlockWidth.text?.floatValue, let blockLength = paverOrBlockLength.text?.floatValue{
            let column =  round(divideBoth(first: feetToInch(feet: wallWidth), second: blockWidth))
            let row =  round(divideBoth(first: feetToInch(feet: wallLength), second: blockLength))
            let capNeeded = column
            let blockNeeded = column * row
            result.text = "You will need approximately \(blockNeeded) blocks and \(capNeeded) caps"
            delegate?.didCalculatePaverOrBlock(controller: self, paverOrBlock: blockNeeded)
            result.isHidden = false
            
        }
      
    }
    
    func calculatePavers(){
       
            if let patioWidth = patioOrWallWidth.text?.floatValue, let patioLength = patioOrWallength.text?.floatValue, let paverWidth = paverOrBlockWidth.text?.floatValue, let paverLength = paverOrBlockLength.text?.floatValue{
                
            
                let patioArea = calculateAreaForRectangularPatternWith(length: patioLength, withWidth: patioWidth)
                let paverArea = calculateAreaForRectangularPatternWith( length:inchToFeet(inch: paverLength), withWidth:inchToFeet(inch: paverWidth))
                
                let numberOfPaver = divideBoth(first: patioArea, second: paverArea)
                let numberOfPaverAfterMargin =  addMargin(amount: numberOfPaver)
                result.text = "You will need approximately \(numberOfPaverAfterMargin) pavers of  \(paverArea) square feet for  \(patioArea) square feet of patio with 5% margin. "
                delegate?.didCalculatePaverOrBlock(controller: self, paverOrBlock: numberOfPaverAfterMargin)
                result.isHidden = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(calculatorType == "Paver Calculator"){
            mainHeading.text = "Patio Size(in feet)"
            subHeading.text = "Paver Size(in inch)"
        }
        else if(calculatorType == "Retaining Wall Calculator"){
            mainHeading.text = "Wall Size(in feet)"
            subHeading.text =  "Block Size(in inch)"
        }
        // Do any additional setup after loading the view.
    }

}
