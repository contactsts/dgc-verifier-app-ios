//
//  UIImageViewKingfisher.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/18/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


extension UIImage {
    
    
        static func loadImage(`with` urlString : String) {
            guard let url = URL.init(string: urlString) else {
                return
            }
            let resource = ImageResource(downloadURL: url)
            
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    
    
}

extension UIImageView {
    
//    func setImage(urlString: String?) {
//        if urlString != nil {
//
//            let url = URL(string: urlString!)
//            let processor = DownsamplingImageProcessor(size: self.frame.size)
//                >> RoundCornerImageProcessor(cornerRadius: 5)
//            self.kf.indicatorType = .activity
//            self.kf.setImage(
//                with: url,
//                placeholder: UIImage(named: "image-placeholder"),
//                options: [
//                    .processor(processor),
//                    .scaleFactor(UIScreen.main.scale),
//                    .transition(.fade(1)),
//                    .cacheOriginalImage
//                ])
//            {
//                result in
//                switch result {
//                case .success(let value):
//                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                case .failure(let error):
//                    print("Job failed: \(error.localizedDescription)")
//                }
//            }
//
//        }
//    }
    
}
