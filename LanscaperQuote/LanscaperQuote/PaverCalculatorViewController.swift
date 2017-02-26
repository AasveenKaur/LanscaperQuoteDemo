//
//  PaverCalculatorViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/20/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

protocol PaverCalculatorViewControllerDelegate {
    func didCalculatePaver(controller: PaverCalculatorViewController,  paver:Float)
}

class PaverCalculatorViewController: UIViewController {
    @IBOutlet weak var patioWidth: UITextField!

    @IBOutlet weak var patioLength: UITextField!
    
    @IBOutlet weak var paverWidth: UITextField!
    
    @IBOutlet weak var paverLength: UITextField!
    
    @IBOutlet weak var result: UILabel!
    var delegate: PaverCalculatorViewControllerDelegate?
    @IBAction func calculateResult(_ sender: Any) {
        if(checkIfTextFieldHasText(textField:patioLength) && checkIfTextFieldHasText(textField:patioWidth) &&
           checkIfTextFieldHasText(textField:paverLength) &&
            checkIfTextFieldHasText(textField:paverWidth)){
            if let patioL = Float(patioLength.text!), let patioW = Float(patioWidth.text!), let paverL = Float(paverLength.text!), let paverW = Float(paverWidth.text!){
        let patioArea = calculateAreaForRectangularPatternWith(length: patioL, withWidth: patioW)
        let paverArea = calculateAreaForRectangularPatternWith(length:inchToFeet(inch: paverL), withWidth:inchToFeet(inch: paverW))
                let numberOfPaver = divideBoth(first: patioArea, second: paverArea)
                let numberOfPaverAfterMargin =  addMargin(amount: numberOfPaver)
             result.text = "You will need approximately \(numberOfPaverAfterMargin) pavers of  \(paverArea) square feet for  \(patioArea) square feet of patio with 5% margin. "
                delegate?.didCalculatePaver(controller: self, paver: numberOfPaverAfterMargin)
        }
        }
        result.isHidden = false

      

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
