//
//  PreviewViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/18/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var webPreview: UIWebView!
    
    var quoteComposer: QuoteComposer!
    
    var HTMLContent: String!
    var quoteDetails = QuotesModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        createInvoiceAsHTML()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createInvoiceAsHTML() {
        quoteComposer = QuoteComposer()
        if let invoiceHTML =  quoteComposer.renderInvoice(invoiceNumber: quoteDetails.estimateNumber, invoiceDate: "\(quoteDetails.date)", recipientInfo: quoteDetails.client.name, items: quoteDetails.LineItems!, totalAmount: "\(quoteDetails.totalAmount)") {
            
            webPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: quoteComposer.pathToInvoiceHTMLTemplate!)! as URL)
            HTMLContent = invoiceHTML
           
            
            
        }
       
        
       
    }

}
