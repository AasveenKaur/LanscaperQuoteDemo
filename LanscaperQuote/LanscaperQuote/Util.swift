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
let EMPTY_SEGUE_RETAINING_WALL_IDENTIFIER = "emptySegueRetainingWall"
let pickOption = ["Select calculator type","Paver Calculator", "Retaining Wall Calculator", "Soil Calculator", "Mulch Calculator", "Grass Seed Calculator", "Sod Calculator", "Plant and Flower Calculator" , " Landscape Material Yardage Calculator" ,"Fence Calculator", "Deck Calculator", "Acreage Calculator", "Other" ]
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



//Mark: - Calculators

func calculateSoilOrMulchVolumeforRectangularPatternWith(length:Float, withWidth width:Float, withDepth depth:Float ) -> Float{
     var volume:Float = 0.0
     volume = length*width*depth
     volume = convertCubicFeetToCubicYardWith(volume: volume)
     volume = roundOffToTwoDecimalPlacesWith(quantity: volume)
     return  volume
}

func calculateSoilOrMulchVolumeforCircularPatternWith(diameter:Float, withDepth depth:Float ) -> Float{
    var volume:Float = 0.0
    volume = (pie*(diameter/2)*(diameter/2)*depth)
    volume = convertCubicFeetToCubicYardWith(volume: volume)
    volume = roundOffToTwoDecimalPlacesWith(quantity: volume)
    return  volume
}

func calculateSoilOrMulchVolumeforTrianglePatternWith(height:Float,withBase base:Float , withDepth depth:Float ) -> Float{
    var volume:Float = 0.0
    volume = (((height*base)/2)*depth)
    volume = convertCubicFeetToCubicYardWith(volume: volume)
    volume = roundOffToTwoDecimalPlacesWith(quantity: volume)
    return  volume
}

func calculateAreaForRectangularPatternWith(length:Float, withWidth width:Float)-> Float{
   return length*width
}


func convertCubicFeetToCubicYardWith(volume:Float) -> Float{
    return volume/Float(CubicFeetToCubicYardConversionNumber)
}

func roundOffToTwoDecimalPlacesWith(quantity:Float) -> Float{
    return round(100*quantity)/100
}



