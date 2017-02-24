//
//  PreviewViewController.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/18/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

import MessageUI
class PreviewViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var webPreview: UIWebView!
    
    var quoteComposer: QuoteComposer!
    
    var HTMLContent: String!
        var quoteDetails = QuotesModel()
    
    @IBAction func printQuote(_ sender: Any) {
        // Make PDF of HTML
        quoteComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
        let urlwithPercentEscapes = self.quoteComposer.pdfFilename.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let request = NSURLRequest(url: NSURL(string: urlwithPercentEscapes!)! as URL)
       
        self.webPreview.loadRequest(request as URLRequest)
    }
    @IBAction func emailQuote(_ sender: Any) {
//        if MFMailComposeViewController.canSendMail() {
//            let mailComposeViewController = MFMailComposeViewController()
//            mailComposeViewController.setSubject("Invoice")
//            mailComposeViewController.addAttachmentData(NSData(contentsOfFile: quoteComposer.pdfFilename)! as Data, mimeType: "application/pdf", fileName: "Invoice")
//            present(mailComposeViewController, animated: true, completion: nil)
//        }
//        
//        
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } 
    }
    @IBAction func deleteQuote(_ sender: Any) {
    }

    
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
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.addAttachmentData(NSData(contentsOfFile: quoteComposer.pdfFilename)! as Data, mimeType: "application/pdf", fileName: "Invoice")

        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
  

    
}
