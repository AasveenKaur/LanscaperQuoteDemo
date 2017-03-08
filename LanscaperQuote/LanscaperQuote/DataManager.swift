//
//  DataManager.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 1/31/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    
    
    func saveQuotes(Quotelist:[QuotesModel]) {
        if let filePath = pathForItems(plist: "quote.plist") {
            NSKeyedArchiver.archiveRootObject(Quotelist, toFile: filePath)
        }
    }

    
    func loadQuotes()  -> [QuotesModel]?{
        if let filePath = pathForItems(plist: "quote.plist"), FileManager.default.fileExists(atPath: filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [QuotesModel] {
               let  Quotelist = archivedItems
                return Quotelist
            }
        }
        return nil
    }
    
    private func pathForItems(plist:String) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent(plist)?.path
        }
        
        return nil
    }
    
    func saveImageDocumentDirectory(image:UIImage){
        
        var imagesDirectoryPath = pathForItems(plist: "ImagePicker")
        print(imagesDirectoryPath!)
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath!, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath!, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
            
            
        // Save image to Document directory
        var imageName = NSDate().description
        imageName = imageName.replacingOccurrences(of: " ", with: "")
        
        
        var imagePath = imagesDirectoryPath?.appending("/\(imageName).png")
        let data = UIImagePNGRepresentation(image)
        let success = FileManager.default.createFile(atPath: imagePath!, contents: data, attributes: nil)
    }
    }
   
    func getImage(imagePath:String){
        let fileManager = FileManager.default
         let pAth = pathForItems(plist: "ImagePicker")
        
        if fileManager.fileExists(atPath: pAth!){
            // self.imageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }

    
    
    
}
