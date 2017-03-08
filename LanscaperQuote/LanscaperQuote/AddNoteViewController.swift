//
//  AddNoteViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/2/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit
protocol AddNoteViewControllerDelegate {
    func controller(controller: AddNoteViewController, didSaveNote note:String )
}

class AddNoteViewController: BaseViewController {
var delegate: AddNoteViewControllerDelegate?
    @IBOutlet weak var note: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        note.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func saveNote(_ sender: Any) {
        delegate?.controller(controller: self, didSaveNote: note.text)
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Enter your note here!"){
            textView.text = ""
        }
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
