//
//  RetainingWallViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/20/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

protocol RetainingWallViewControllerDelegate {
    func didCalculateRetainingBlocks(controller: RetainingWallViewController,  blocks:Float)
}

class RetainingWallViewController: UIViewController {
var delegate: RetainingWallViewControllerDelegate?
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
        /*
         Divide the width of the wall in inches by the width of the block and round up, this is the number of columns. Divide the height of the wall in inches by the height of the block and round up, this is the number of rows. If the top row will be a cap block then the number of cap blocks needed is the number of columns. To find the total number of blocks needed for the wall simply multiple the number of columns by the number of rows; don’t forget to subtract a row if using cap blocks.
         
        */
        
       let column =  round(divideBoth(first: feetToInch(feet: Float(wallWidth.text!)!), second: Float(blockWidth.text!)!))
       let row =     round(divideBoth(first: feetToInch(feet: Float(wallHeight.text!)!), second: Float(blockHeight.text!)!))
       var capNeeded = column
       var blockNeeded = column * row
        blockNeeded = addMargin(amount: blockNeeded)
        capNeeded = addMargin(amount: capNeeded)
        result.text = "You will need approximately blockNeeded \(blockNeeded) blocks and \(capNeeded) caps"
        delegate?.didCalculateRetainingBlocks(controller: self, blocks: blockNeeded+capNeeded )
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
