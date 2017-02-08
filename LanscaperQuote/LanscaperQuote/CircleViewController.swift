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

class CircleViewController: UIViewController {
    var delegate: CircleViewControllerDelegate?
    @IBAction func circleCalculateButtonPressed(_ sender: Any) {
        let volume = calculateVolume()
        delegate?.controller(controller: self, didCalculateArea: volume)
        result.text = "You will need approximately \(volume) cubic yards of soil"
        result.isHidden = false
    }
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var bedDiameter: UITextField!
    
    @IBOutlet weak var bedDepth: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func calculateVolume() -> Float {
        var volume:Float = 0.0
        
        if let depth = Float(bedDepth.text!), let diameter = Float(bedDiameter.text!){
            volume = (pie*(diameter/2)*(diameter/2)*depth)/27  // convert into cubic yard
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
