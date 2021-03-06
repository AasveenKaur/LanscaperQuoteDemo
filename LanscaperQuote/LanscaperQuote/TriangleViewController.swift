//
//  RectangleViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol TriangleViewControllerDelegate {
    func controller(controller: TriangleViewController, didCalculateTriangleMulchQuantity mulch:Float, forBag bagVolume: Float)
}

class TriangleViewController: BaseViewController {
    var calculatorType:String = ""
    var delegate: TriangleViewControllerDelegate?
    @IBOutlet weak var bedBase: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var bedHeight: UITextField!
    
    @IBOutlet weak var bedDepth: UITextField!
    
    @IBAction func triangleCalculateButtonPressed(_ sender: Any) {
        
        let volume = calculateVolume()
        delegate?.controller(controller: self, didCalculateTriangleMulchQuantity: volume, forBag: 2)
        if(calculatorType == "Mulch Calculator"){
        result.text = "You will need approximately \(volume) cubic yards of mulch"
        }else if(calculatorType == "Soil Calculator"){
            result.text = "You will need approximately \(volume) cubic yards of soil"
        }
        result.isHidden = false
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        bedBase.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        bedHeight.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        bedDepth.inputAccessoryView = getDoneButtonOnKeyboard(target: self, action: #selector(RectangleViewController.doneButtonAction))
        // Do any additional setup after loading the view.
    }
    
    func calculateVolume() -> Float {
        var volume:Float = 0.0
        
        if let depth = Float(bedDepth.text!), let height = Float(bedHeight.text!), let base = Float(bedBase.text!){
         volume =  calculateSoilOrMulchVolumeforTrianglePatternWith(height: height, withBase: base, withDepth: depth)
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
        self.bedBase.resignFirstResponder()
        self.bedDepth.resignFirstResponder()
        self.bedHeight.resignFirstResponder()
        
    }


}
