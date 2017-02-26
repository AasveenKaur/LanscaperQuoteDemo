//
//  QuoteComposer.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/18/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class QuoteComposer: NSObject {
    
    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "invoice", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "single_item", ofType: "html")
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "last_item", ofType: "html")
    
    let senderInfo = "Gabriel Theodoropoulos<br>123 Somewhere Str.<br>10000 - MyCity<br>MyCountry"
    
    let dueDate = ""
    
    let paymentMethod = "Wire Transfer"
    
    let logoImageURL = Bundle.main.path(forResource: "Acme", ofType: "png")
    
   
    
    var invoiceNumber: String!
    var invoiceDate: String!
    var recipientInfo:String!
    var totalAmount:String!
    var pdfFilename: String!
    var items:Set<LineItem>!
    
    override init(){
        super.init()
    }
    
//    func renderInvoice(invoiceNumber: String, invoiceDate: String, recipientInfo: String, items: [LineItemModel], totalAmount: String) -> String! {
        // Store the invoice number for future use.
    func renderInvoice(selectedQuote:Quote) -> String! {
       
        
        if let invoiceNumber = selectedQuote.estimateNumber{
            self.invoiceNumber = invoiceNumber
        }
        if let invoiceDate = selectedQuote.date{
            self.invoiceDate = "\(invoiceDate)"
        }
        if let client = selectedQuote.value(forKey: "client") as? Client {
            self.recipientInfo = client.name
        }
        if let lineItems = selectedQuote.value(forKey:"lineItems") as? Set<LineItem>{
            self.items = lineItems
            for l in lineItems{
                
                print("LineItem->\( l.itemName)")
                print("LineItem->\( l.itemDescription)")
            }
            print("-------")
        }
        self.totalAmount = "\(selectedQuote.totalAmount)"
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            let murl = NSURL(fileURLWithPath: logoImageURL!)
            HTMLContent = HTMLContent.replacingOccurrences(of:"#LOGO_IMAGE#", with: "\(murl)")
            
           
            // Invoice number.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#INVOICE_NUMBER#", with: invoiceNumber)
            
            // Invoice date.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#INVOICE_DATE#", with: invoiceDate)
            
            // Due date (we leave it blank by default).
            HTMLContent = HTMLContent.replacingOccurrences(of:"#DUE_DATE#", with: dueDate)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#SENDER_INFO#", with: senderInfo)
            
            // Recipient info.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#RECIPIENT_INFO#", with: recipientInfo.replacingOccurrences(of:"\n", with: "<br>"))
            
            // Payment method.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#PAYMENT_METHOD#", with: paymentMethod)
            
            // Total amount.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#TOTAL_AMOUNT#", with: totalAmount)
            
            // The invoice items will be added by using a loop.
            var allItems = ""
            
            // For all the items except for the last one we'll use the "single_item.html" template.
            // For the last one we'll use the "last_item.html" template.
            var i = 0
            for item in items {
               
                var itemHTMLContent: String!
                
                // Determine the proper template file.
                if i != items.count - 1 {
                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                }
                else {
                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
                }
                
                // Replace the description and price placeholders with the actual values.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#ITEM_DESC#", with: item.itemName!)
                
                // Format each item's price as a currency value.
                //let formattedPrice = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(items[i]["price"]!)
                
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with: getStringValueFormattedAsCurrency("\(item.price)"))
                //itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with: "100")

                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
                i += 1
            }
            
            // Set the items.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#ITEMS#", with: allItems)
            
            // The HTML code is ready.
            return HTMLContent
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
   
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        pdfFilename = "\(getDocDir())/Invoice\(invoiceNumber).pdf"
        pdfData?.write(toFile: pdfFilename, atomically: true)
        
        print(pdfFilename)
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
    
    let pdfData = NSMutableData()
    
    UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
       
        for i in 0 ..< printPageRenderer.numberOfPages{
    UIGraphicsBeginPDFPage()
    
    printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
    UIGraphicsEndPDFContext()
    
    return pdfData
        
    }
}


