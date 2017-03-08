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
    var quoteDetails:Quote!
    
    
    

    @IBOutlet weak var myToolBar: UIToolbar!
    override func viewDidLoad() {
       setUpCustomBar()
        
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUpCustomBar()  {
        let barItemOneButton = buttonForBarItemWith(imageName: "email.png", title: "Email")
        barItemOneButton.addTarget(self, action:  #selector(self.emailQuote), for: .touchUpInside)
        myToolBar.items?[0] = UIBarButtonItem(customView: barItemOneButton)
        
        let barItemTwoButton = buttonForBarItemWith(imageName: "printer.png", title: "Print")
        barItemTwoButton.addTarget(self, action:  #selector(self.printQuote), for: .touchUpInside)
        myToolBar.items?[1] = UIBarButtonItem(customView: barItemTwoButton)

        let barItemThreeButton = buttonForBarItemWith(imageName: "dollar-sign.png", title: "To Invoice")
        barItemThreeButton.addTarget(self, action:  #selector(self.convertToInvoice), for: .touchUpInside)
        myToolBar.items?[2] = UIBarButtonItem(customView: barItemThreeButton)
        
        let barItemFourButton = buttonForBarItemWith(imageName: "recycle-bin.png", title: "Delete")
        barItemFourButton.addTarget(self, action:  #selector(self.deleteQuote), for: .touchUpInside)
        myToolBar.items?[3] = UIBarButtonItem(customView: barItemFourButton)
        
        
        
        
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
        
      if let invoiceHTML = quoteComposer.renderInvoice(selectedQuote: quoteDetails){
            HTMLContent = invoiceHTML
            webPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: quoteComposer.pathToInvoiceHTMLTemplate!)! as URL)

           
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        // Extremely important to set the --mailComposeDelegate-- property,  NOT the --delegate-- property
        mailComposerVC.addAttachmentData(NSData(contentsOfFile: quoteComposer.pdfFilename)! as Data, mimeType: "application/pdf", fileName: "Invoice")

        mailComposerVC.setToRecipients([(quoteDetails.client?.email!)!])
        mailComposerVC.setSubject("Your quote \(quoteDetails.estimateNumber!)# from Acme Co.")
        mailComposerVC.setMessageBody("We are excited about the possibility of working with you.", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       var  message = ""
        if(result == .cancelled){
            message = "Email was not sent!"
        }
        else if (result == .failed){
            message = "Email sending failed!"
        }
        else if (result == .saved){
             message = "Email saved as draft!"
        }
        else if (result == .sent){
            message = "Email sent succesfully!"
        }
        controller.dismiss(animated: true) { 
            showAlert(readableErrorDescription: message, viewController: self)
        }
       
    }
    
  
    @IBAction func convertToInvoice(_ sender: Any) {
        let oldStatus = quoteDetails.invoiceStatus
        let newStatus = !oldStatus
        showInvoiceAlert(quote: quoteDetails, viewController: self, status:newStatus)
       
    }
    @IBAction func printQuote(_ sender: Any) {
       
        //let request = makePDFOfHTML()
        //self.webPreview.loadRequest(request as URLRequest)
        showAlert(readableErrorDescription: "Air printer functionality coming soon!", viewController: self)
    }
    
    func makePDFOfHTML() -> NSURLRequest{
    // Make PDF of HTML
    quoteComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
    let urlwithPercentEscapes = self.quoteComposer.pdfFilename.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    let request = NSURLRequest(url: NSURL(string: urlwithPercentEscapes!)! as URL)
    return request
    }
    
    @IBAction func emailQuote(_ sender: Any) {
        self.makePDFOfHTML()
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    @IBAction func deleteQuote(_ sender: Any) {
        DataProvider.sharedInstance.deleteQuote(quote: quoteDetails)
        dismiss(animated: true) { 
            
        }
    }

    
}
