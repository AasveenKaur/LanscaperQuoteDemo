//
//  ThemeManager.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/4/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import Foundation
import UIKit

enum shape {
    case rectangular
    case circular
    case triangle
   }


let EMPTY_SEGUE_RECTANGLE_IDENTIFIER  = "emptySegueRectangle"
let EMPTY_SEGUE_CIRCLE_IDENTIFIER = "emptySegueCircle"
let EMPTY_SEGUE_TRIANGLE_IDENTIFIER = "emptySegueTriangle"
let EMPTY_SEGUE_PAVER_IDENTIFIER = "emptySeguePaver"
let EMPTY_SEGUE_GRASS_SEED_IDENTIFIER = "emptySegueGrassSeed"
let ESTIMATE_NUMBER = "estimateNumber"
let pickOption = ["Select calculator type","Paver Calculator", "Retaining Wall Calculator", "Soil Calculator", "Mulch Calculator", "Grass Seed Calculator", "Sod Calculator", "Plant and Flower Calculator" , " Landscape Material Yardage Calculator" , "Acreage Calculator", "Other" ]//"Fence Calculator", "Deck Calculator",
//let pickOption = ["Select calculator type", "Soil Calculator", "Mulch Calculator"]

let pie:Float = 3.14

 let currencyCode = "$"
let CubicFeetToCubicYardConversionNumber = 27



func getStringValueFormattedAsCurrency(_ value: String) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.currency
    numberFormatter.currencyCode = currencyCode
    numberFormatter.maximumFractionDigits = 2
    
    let formattedValue = numberFormatter.string(from: NumberFormatter().number(from: value)!)
    return formattedValue!
}


func getDocDir() -> String {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
}



var estimateNumberGenerator:Int{
get{
    return UserDefaults.standard.object(forKey: ESTIMATE_NUMBER) as? Int ?? 1
}
set{
    let defaults = UserDefaults.standard
    let int = defaults.integer(forKey: ESTIMATE_NUMBER)
    if(int == 0){
    defaults.set(int+2, forKey:ESTIMATE_NUMBER)
    }else{
         defaults.set(int+1, forKey:ESTIMATE_NUMBER)
    }
    defaults.synchronize()
}
}
extension UserDefaults {
    class func incrementIntegerForKey(key:String) {
        let defaults = standard
        let int = standard.integer(forKey: key)
        defaults.set(int+1, forKey:key)
        defaults.synchronize()
    }
}



//Mark: - Calculators

func calculateSoilOrMulchVolumeforRectangularPatternWith(length:Float, withWidth width:Float, withDepth depth:Float ) -> Float{
     var volume:Float = 0.0
     volume = length * width * depth
     volume = convertCubicFeetToCubicYardWith(volume: volume)
     volume = roundOffToTwoDecimalPlacesWith(quantity: volume)
     return  volume
}

func calculateSoilOrMulchVolumeforCircularPatternWith(diameter:Float, withDepth depth:Float ) -> Float{
    var volume:Float = 0.0
    volume = (pie * (diameter / 2) * (diameter / 2) * depth)
    volume = convertCubicFeetToCubicYardWith(volume: volume)
    volume = roundOffToTwoDecimalPlacesWith(quantity: volume)
    return  volume
}

func calculateSoilOrMulchVolumeforTrianglePatternWith(height:Float,withBase base:Float , withDepth depth:Float ) -> Float{
    var volume:Float = 0.0
    volume = (((height * base) / 2) * depth)
    volume = convertCubicFeetToCubicYardWith(volume: volume)
    volume = roundOffToTwoDecimalPlacesWith(quantity: volume)
    return  volume
}

func calculateAreaForRectangularPatternWith(length:Float, withWidth width:Float)-> Float{
   return length * width
}


func convertCubicFeetToCubicYardWith(volume:Float) -> Float{
    return volume/Float(CubicFeetToCubicYardConversionNumber)
}

func roundOffToTwoDecimalPlacesWith(quantity:Float) -> Float{
    return round(100*quantity)/100
}

func showAlert(readableErrorDescription:String,viewController:UIViewController)  {
    let alertController:UIAlertController =  UIAlertController(title:  "Alert!", message: readableErrorDescription, preferredStyle: .alert)
    
    
    alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler:{(alert: UIAlertAction!) in
        
    }))
    
    viewController.present(alertController, animated: true, completion: nil)
}

func showInvoiceAlert(quote:Quote,viewController:UIViewController, status:Bool)  {
    var message = ""
    if (status == true){
        message = "Are you sure you want to convert Quote to Invoice?"
    }
    else{
        message = "Are you sure you want to convert Invoice to Quote?"
    }
    let alertController:UIAlertController =  UIAlertController(title:  "Alert!", message:message , preferredStyle: .alert)
    
    
    alertController.addAction(UIAlertAction(title: "YES", style: .default, handler:{(alert: UIAlertAction!) in
        DataProvider.sharedInstance.updateQuoteInvoiceStatus(quote: quote , status: status)
    }))
    
    alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler:nil))
    
    viewController.present(alertController, animated: true, completion: nil)
}

func checkIfTextFieldHasText(textField:UITextField) -> Bool {
    if let text = textField.text, !text.isEmpty
    {
        //return true if it's not empty
        return true
    }
    return false
}

func getDoneButtonOnKeyboard(target: Any?, action: Selector?) -> UIToolbar
{
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
    doneToolbar.barStyle       = UIBarStyle.default
    let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: target, action: action)
    
    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)
    
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    return doneToolbar
}

func calculateTaxOn(amount:Float, taxPercentage:Float) -> Float{
    return roundOffToTwoDecimalPlacesWith(quantity: amount * (taxPercentage / Float(100)))
}


func calculateSubtotal(price:Float, quantity:Float) -> Float {
    return roundOffToTwoDecimalPlacesWith(quantity: price * quantity)
}

func calculateSubtotalWithTax(subTotal:Float, tax:Float) -> Float {
    return roundOffToTwoDecimalPlacesWith(quantity: subTotal + calculateTaxOn(amount: subTotal, taxPercentage: tax))
}



func divideBoth(first:Float, second:Float) -> Float{
    return first / second
}


func addMargin(amount:Float) -> Float{
    return calculateSubtotalWithTax(subTotal: amount,tax: 5)
}

func applyDiscount(amount:Float, discount:Float) -> Float{
    return amount - calculateTaxOn(amount: amount, taxPercentage:discount)
}

func inchToFeet(inch:Float) -> Float{
 return inch / Float(12)
}

func feetToInch(feet:Float) -> Float{
    return feet * Float(12)
}



extension String {
    var floatValue: Float! {
        return (self as NSString).floatValue
    }
}


extension UIButton {
    func centerLabelVerticallyWithPadding(spacing:CGFloat) {
        // update positioning of image and title
        let imageSize = self.imageView!.frame.size
        self.titleEdgeInsets = UIEdgeInsets(top:0,
                                            left:-imageSize.width,
                                            bottom:-(imageSize.height + spacing),
                                            right:0)
        let titleSize = self.titleLabel!.frame.size
        self.imageEdgeInsets = UIEdgeInsets(top:-(titleSize.height + spacing),
                                            left:0,
                                            bottom: 0,
                                            right:-titleSize.width)
        
        // reset contentInset, so intrinsicContentSize() is still accurate
        let trueContentSize = self.titleLabel!.frame.union(self.imageView!.frame).size
        let oldContentSize = self.intrinsicContentSize
        let heightDelta = trueContentSize.height - oldContentSize.height
        let widthDelta = trueContentSize.width - oldContentSize.width
        self.contentEdgeInsets = UIEdgeInsets(top:heightDelta/2.0,
                                              left:widthDelta/2.0,
                                              bottom:heightDelta/2.0,
                                              right:widthDelta/2.0)
    }
}

func buttonForBarItemWith(imageName: String, title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: imageName), for: .normal)
    button.setTitle(title, for: .normal)
    button.sizeToFit()
    button.centerLabelVerticallyWithPadding(spacing: 0)
    return button
}

 func EmptyMessage(message:String, viewController:UITableViewController) {
    
    let attachment = NSTextAttachment()
    attachment.image = UIImage(named: "arrow-small-17.png")
    let attachmentString = NSAttributedString(attachment: attachment)
    let myString = NSMutableAttributedString(string: message)
    myString.append(attachmentString)
    
    
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        messageLabel.attributedText = myString
    messageLabel.textColor = UIColor(red: 0.04, green: 0.16, blue: 0.35, alpha: 1.0)
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = .center;
    messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
    messageLabel.sizeToFit()
    
    viewController.tableView.backgroundView = messageLabel;
    viewController.tableView.separatorStyle = .none;
}

func resetBackground(viewController:UITableViewController){
    let backgroundImage = UIImage(named: "background")
    let imageView = UIImageView(image: backgroundImage)
    viewController.tableView.backgroundView = imageView
    
   
    
}
