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

class TriangleViewController: UIViewController {
    var delegate: TriangleViewControllerDelegate?
    @IBOutlet weak var bedBase: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var bedHeight: UITextField!
    
    @IBOutlet weak var bedDepth: UITextField!
    
    @IBAction func triangleCalculateButtonPressed(_ sender: Any) {
        
        let volume = calculateVolume()
        delegate?.controller(controller: self, didCalculateTriangleMulchQuantity: volume, forBag: 2)
        result.text = "You will need approximately \(volume) cubic yards of soil"
        result.isHidden = false
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func calculateVolume() -> Float {
        var volume:Float = 0.0
        
        if let depth = Float(bedDepth.text!), let height = Float(bedHeight.text!), let base = Float(bedBase.text!){
            volume = (((height*base)/2)*depth)/27  // convert into cubic yard
            volume = round(100*volume)/100 // Round off to 2 decimal
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
    


}
