//
//  ImageUtils.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 12/29/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

class ImageUtils {
    
    
    // =============================== IMAGE PATHING ====================================
    
    
    public static func getURLForImage( _ imageName : String) -> URL {
        return Bundle.main.url(forResource: imageName, withExtension: "png")!
    }
    
    public static func getPlaceHolderImage() -> URL {
        return self.getURLForImage("image-placeholder")
    }
    
    
    //    Turn file://xxx...xxx/ScorePal.app/abc/image-placeholder.png -> abc/image-placeholder.png
    public static func getShortImageURL(longURL: String) -> String? {
        if (longURL.hasPrefix("http")) {
            return longURL
        }
        return FileUtils.absoluteToRelative(absolute: longURL)
    }
    
    //    Turn file://xxx...xxx/ScorePal.app/abc/image-placeholder.png -> abc/image-placeholder.png
    public static func getLongImageURL(shortURL: String?) -> String? {
        guard let shortURL = shortURL else {
            return nil
        }
        
        if (shortURL.hasPrefix("http")) {
            return shortURL
        }
        
        if (shortURL.hasPrefix("file")) {
            return shortURL
        }
        return FileUtils.relativeToAbsolute(relative: shortURL)
    }
    
    
    public static func getLongImageURLOrPlaceholder(shortURL: String?) -> String {
        return ImageUtils.getLongImageURL(shortURL: shortURL) ?? ImageUtils.getPlaceHolderImage().absoluteString
    }
    
    
    
    
    // =============================== UIKIT ====================================
    
    
    
    static func loadImageIntoView(relativePath: String?, imageView: UIImageView) {
        let imageURL = ImageUtils.getLongImageURL(shortURL: relativePath ?? "")
        imageView.nukeImage(url: imageURL)
    }
    
    
    static func scaleImage(sourceImage: UIImage, toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = sourceImage.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
    
    
    
    
    public static func getGameImageView() -> UIImageView {
        let view = UIImageView()
//        view.addShadows()
        view.addCorners()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }
    
    
    public static func getPlayerImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.addShadows()
        view.addCorners()
        return view
    }
    
    // -----------------------------------------------
    
    public static func getDefaultPlayerImages() -> [String] {
        let imagesList = (1...100).map{ "player\($0)" }
        return imagesList
    }
    
    public static func getDefaultGameImages() -> [String] {
        let imagesList = (1...16).map{ "game\($0)" }
        return imagesList
    }
    
    public static func getDefaultLocationImages() -> [String] {
        let imagesList = (1...14).map{ "location\($0)" }
        return imagesList
    }
    
}
