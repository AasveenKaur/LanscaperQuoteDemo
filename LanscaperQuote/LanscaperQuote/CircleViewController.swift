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
        delegate?.controller(controller: self, didCalculateArea: 20)
        result.text = "You will need approximately 0.62 cubic yards of soil"
    }
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var bedDiameter: UITextField!
    
    @IBOutlet weak var bedDepth: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
