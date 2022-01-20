//
//  FileUtils.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/31/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

enum ImageCategory : String {
    case player, game, location, play, playerGroup
}

class FileUtils {
    
    public static func deleteFile(path: String) -> Bool {
        //TODO: Check if file exists
        let fileURL = URL(string: path)
        if  let fileURLValue = fileURL {
            if (!fileURLValue.checkFileExist()){
                return false
            }
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch let error as NSError {
            print("Error: \(error.domain)")
        }
        return false
    }
    
    
    public static func saveImage(category: ImageCategory,  image: UIImage?) -> URL? {
        
        guard let image = image else {
            return nil
        }
        
        guard let documentDirectoryPath = self.getDocumentsURL() else {
            return nil
        }
        
        let destinationFolder = documentDirectoryPath.appendingPathComponent(category.rawValue, isDirectory: true)
        do {
            try FileManager.default.createDirectory(atPath: destinationFolder.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
        
        let imageFileName = "\(category.rawValue)-\(DateUtils.getMillis()).png"
        
        let imagePath = destinationFolder.appendingPathComponent(imageFileName)
        //        return image.savePng(imagePath)
        
        
        do {
            //Use .pngData() if you want to save as PNG.
            //.atomic is just an example here, check out other writing options as well. (see the link under this example)
            //(atomic writes data to a temporary file first and sending that file to its final destination)
            try image.jpegData(compressionQuality: 1)?.write(to: imagePath, options: .atomic)
            return imagePath
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    public static func getDocumentsURL() -> URL? {
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectoryPath
    }
    
    
    public static func relativeToAbsolute(relative: String) -> String? {
        if let documentsURL = self.getDocumentsURL() {
            return documentsURL.appendingPathComponent(relative).absoluteString
        }
        return nil
    }
    
    public static func absoluteToRelative(absolute: String) -> String? {
        let url = URL(string: absolute)
        guard let documentsURL = self.getDocumentsURL() else {
            return nil
        }
        
        return url?.relativePath(from: documentsURL)
    }
    
//    public static func absoluteToRelative(url: URL) -> String? {
//        if let documentsURL = self.getDocumentsURL() {
//            return url.relativePath(from: documentsURL)
//        }
//
//        return nil
//    }
    

    
    
    
    
    
    
}
