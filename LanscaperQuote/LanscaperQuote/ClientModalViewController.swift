//
//  ClientModalViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/8/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol ClientModalViewControllerDelegate {
    
    func controller(controller: ClientModalViewController, didSaveClientWithName name: String, phoneNumber phoneNo: String, emailAddress email:String)
    
    
}
class ClientModalViewController: UIViewController {
    var delegate: ClientModalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var clinetEmail: UITextField!
    @IBOutlet weak var clinetPhone: UITextField!
    @IBOutlet weak var clinetName: UITextField!
    @IBAction func saveClientInfoButtonPressed(_ sender: Any) {
        delegate?.controller(controller: self, didSaveClientWithName: self.clinetName.text!, phoneNumber: self.clinetPhone.text!, emailAddress: self.clinetEmail.text!)
        dismiss(animated: true) { 
            
        }
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
