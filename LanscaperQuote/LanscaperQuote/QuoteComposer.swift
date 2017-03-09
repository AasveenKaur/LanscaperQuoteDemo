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
    let pathToTaxItemHTMLTemplate = Bundle.main.path(forResource: "tax_item", ofType: "html")
    
    let pathToPhotoHTMLTemplate = Bundle.main.path(forResource: "photo_item", ofType: "html")
    
    
    
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
    var photos:Set<Photo>!
    
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
        if let allPhotos = selectedQuote.value(forKey: "photos") as? Set<Photo>{
            self.photos = allPhotos
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
            
            // The invoice items will be added by using a loop.
            var allItems = ""
            var alltax:Float = 0.0
            var allSubTotal:Float = 0.0
            var i = 0
            for item in items {
               
                var itemHTMLContent: String!
                itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                
                
                // Replace the description and price placeholders with the actual values.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#ITEM_DESC#", with: item.itemName!)
              
                let subTotal:Float = calculateSubtotal(price: item.price, quantity: item.quantity)
                 let subTotalPDF = getStringValueFormattedAsCurrency("\(subTotal)")
        itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with:"$\(subTotalPDF)")
                //itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with: "100")

                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
                i += 1
                let taxOnSubtotal:Float = calculateTaxOn(amount: subTotal, taxPercentage:item.tax)
                alltax = roundOffToTwoDecimalPlacesWith(quantity: Float(alltax) + taxOnSubtotal)
                allSubTotal = roundOffToTwoDecimalPlacesWith(quantity:(allSubTotal + subTotal))
                }
            var discountValuePDF = "$0.0"
            var taxValuePDF = "$\(alltax)"
             var totalValuePDF = "$\(self.totalAmount!)"
            if(selectedQuote.discount != 0){
                let discount = calculateTaxOn(amount: allSubTotal, taxPercentage: selectedQuote.discount)
                if (discount != 0.0){
                    discountValuePDF = "-$\(calculateTaxOn(amount: allSubTotal, taxPercentage: selectedQuote.discount))"
                }
                
               taxValuePDF = "$\(applyDiscount(amount:alltax , discount: selectedQuote.discount))"
               totalValuePDF =   "$\(applyDiscount(amount:allSubTotal , discount: selectedQuote.discount) + applyDiscount(amount:alltax , discount: selectedQuote.discount))"
            }
            
            // Total amount.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#TOTAL_AMOUNT#", with: totalValuePDF)
            // Set TAX and discount
                var taxHTMLContent = try String(contentsOfFile: pathToTaxItemHTMLTemplate!)
                // Replace the description and price placeholders with the actual values.
                taxHTMLContent = taxHTMLContent.replacingOccurrences(of:"#TAX_DESC#", with: "Tax")
                taxHTMLContent = taxHTMLContent.replacingOccurrences(of:"#TAX#", with: taxValuePDF)
                allItems += taxHTMLContent
            
          
                var discountHTMLContent = try String(contentsOfFile: pathToTaxItemHTMLTemplate!)

                 discountHTMLContent = discountHTMLContent.replacingOccurrences(of:"#TAX_DESC#", with: "Discount")
                discountHTMLContent = discountHTMLContent.replacingOccurrences(of:"#TAX#", with:discountValuePDF)
                allItems += discountHTMLContent
            
            // Set the items.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#ITEMS#", with: allItems)
            // Set Notes
            HTMLContent = HTMLContent.replacingOccurrences(of:"#NOTES#", with: selectedQuote.note!)
            // Set photo_item
            var allPhotos = ""
            for photo in self.photos {
           var  photoHTMLContent = try String(contentsOfFile: pathToPhotoHTMLTemplate!)
              
                
                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                if let dirPath          = paths.first
                {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(photo.path!)
                
                if  (FileManager.default.fileExists(atPath: imageURL.path)){
                    let im = UIImage(contentsOfFile: imageURL.path)
                    print(im!)
                }
                    let murl = NSURL(fileURLWithPath: imageURL.path)
                    
                    photoHTMLContent = photoHTMLContent.replacingOccurrences(of:"#ATTACH_IMAGE#", with: imageURL.path)
                    allPhotos += photoHTMLContent
                    
                }
            
            }
            HTMLContent = HTMLContent.replacingOccurrences(of:"#PHOTOS#", with: allPhotos)
            // The HTML code is ready.
            return HTMLContent
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
//    tax = roundOffToTwoDecimalPlacesWith(quantity:(tax + item.tax))
//}
//// Set TAX and discount
//var itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
//// Replace the description and price placeholders with the actual values.
//itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#ITEM_DESC#", with: "Tax")
//itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with: "\(tax)")
//
//itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#ITEM_DESC#", with: "Discount")
//itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with: "\(selectedQuote.discount)")
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


