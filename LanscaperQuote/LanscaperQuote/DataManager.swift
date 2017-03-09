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
    
    func saveImageDocumentDirectory(image:UIImage) -> String{
        
//        let imagesDirectoryPath = pathForItems(plist: "ImagePicker")
//        print(imagesDirectoryPath!)
//        var objcBool:ObjCBool = true
//        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath!, isDirectory: &objcBool)
//        // If the folder with the given path doesn't exist already, create it
//        if isExist == false{
//            do{
//                try FileManager.default.createDirectory(atPath: imagesDirectoryPath!, withIntermediateDirectories: true, attributes: nil)
//            }catch{
//                print("Something went wrong while creating a new folder")
//            }
//        }
//        
//        // Save image to Document directory
//        var imageName = NSDate().description
//        imageName = imageName.replacingOccurrences(of: " ", with: "")
//        
//        
//        let imagePath = imagesDirectoryPath?.appending("/\(imageName).png")
//        let data = UIImagePNGRepresentation(image)
//        let success = FileManager.default.createFile(atPath: imagePath!, contents: data, attributes: nil)
//        if(success){
//            return imagePath!
//        }
//        return ""
        
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        var imageName = NSDate().description
        imageName = imageName.replacingOccurrences(of: " ", with: "")
        // create a name for your image
        let fileURL = documentsDirectoryURL.appendingPathComponent(imageName)
        
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try UIImagePNGRepresentation(image)!.write(to: fileURL)
                print("Image Added Successfully")
            } catch {
                print(error)
            }
        } else {
            print("Image Not Added")
        }
    return imageName
    }
   
    func getImage(imagePath:String) -> UIImage{
//        let fileManager = FileManager.default
//        
//        
//        if fileManager.fileExists(atPath: imagePath){
//            return UIImage(contentsOfFile: imagePath)!
//        }else{
//            print("No Image")
//        }
//        return UIImage()
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(imagePath)
            let image    = UIImage(contentsOfFile: imageURL.path)
            // Do whatever you want with the image
            return image!
        }
        return UIImage()
    }

    
    
    
}
