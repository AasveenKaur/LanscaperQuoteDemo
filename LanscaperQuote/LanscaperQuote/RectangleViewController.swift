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
   
    @IBOutlet weak var bedDepth: UITextField!
    @IBOutlet weak var bedLength: UITextField!
    
    @IBOutlet weak var bedWidth: UITextField!
    var delegate: RectangleViewControllerDelegate?
    @IBAction func calculateButtonPressed(_ sender: Any) {
        delegate?.controller(controller: self, didCalculateMulchQuantity: 10, forBag: 100)
        
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
