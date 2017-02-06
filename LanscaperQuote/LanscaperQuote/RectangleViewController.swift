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

class RectangleViewController: UIViewController {
   
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var bedDepth: UITextField!
    @IBOutlet weak var bedLength: UITextField!
    
    @IBOutlet weak var bedWidth: UITextField!
    var delegate: RectangleViewControllerDelegate?
    @IBAction func calculateButtonPressed(_ sender: Any) {
        var volume = ((Float(bedDepth.text!)!/12)*Float(bedLength.text!)!*Float(bedWidth.text!)!)/27
        volume = round(100*volume)/100
        delegate?.controller(controller: self, didCalculateMulchQuantity: volume, forBag: 100)
        result.text = "You will need approximately \(volume) cubic yards of soil"
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
    


}
