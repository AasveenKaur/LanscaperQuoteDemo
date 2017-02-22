//
//  RetainingWallViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/20/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class RetainingWallViewController: UIViewController {

    @IBOutlet weak var wallWidth: UITextField!
    
    @IBOutlet weak var wallHeight: UITextField!
    
    @IBOutlet weak var blockWidth: UITextField!
    
    @IBOutlet weak var blockHeight: UITextField!
    
    @IBOutlet weak var blockPrice: UITextField!
    
    @IBOutlet weak var capWidth: UITextField!
    
    @IBOutlet weak var capHeight: UITextField!
    
    @IBOutlet weak var capPrice: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func calculateResult(_ sender: Any) {
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
