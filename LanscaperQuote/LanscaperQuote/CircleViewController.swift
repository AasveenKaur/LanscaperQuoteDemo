//
//  RectangleViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol CircleViewControllerDelegate {
    func controller(controller: CircleViewController, didCalculateArea area:Float)
}

class CircleViewController: BaseViewController {
    var delegate: CircleViewControllerDelegate?
    var calculatorType:String = ""
    @IBAction func circleCalculateButtonPressed(_ sender: Any) {
        let volume = calculateVolume()
        delegate?.controller(controller: self, didCalculateArea: volume)
        if(calculatorType == "Mulch Calculator"){
        result.text = "You will need approximately \(volume) cubic yards of mulch"
        }else if(calculatorType == "Soil Calculator"){
            result.text = "You will need approximately \(volume) cubic yards of soil"
        }
        result.isHidden = false
    }
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var bedDiameter: UITextField!
    
    @IBOutlet weak var bedDepth: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bedDiameter.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        bedDepth.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        
        // Do any additional setup after loading the view.
    }
    
    func calculateVolume() -> Float {
        var volume:Float = 0.0
        
        if let depth = Float(bedDepth.text!), let diameter = Float(bedDiameter.text!){
            volume = calculateSoilOrMulchVolumeforCircularPatternWith(diameter: diameter, withDepth: depth)
        }
        else{
            print("ERROR IN INPUT")
        }
        return volume
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       func doneButtonAction()
    {
        self.bedDiameter.resignFirstResponder()
        self.bedDepth.resignFirstResponder()
        
    }



}
