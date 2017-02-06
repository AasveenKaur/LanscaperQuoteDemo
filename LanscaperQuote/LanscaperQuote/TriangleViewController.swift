//
//  RectangleViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol TriangleViewControllerDelegate {
    func controller(controller: TriangleViewController, didCalculateMulchQuantity mulch:Float, forBag bagVolume: Float)
}

class TriangleViewController: UIViewController {
    var delegate: TriangleViewControllerDelegate?
    @IBOutlet weak var bedBase: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var bedHeight: UITextField!
    
    @IBOutlet weak var bedDepth: UITextField!
    
    @IBAction func triangleCalculateButtonPressed(_ sender: Any) {
        result.text = "You will need approximately 0.62 cubic yards of soil"
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
