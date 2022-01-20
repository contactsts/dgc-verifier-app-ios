//
//  UIImage+Nuke.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/31/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import Nuke

extension UIImageView {
    
    public func nukeImage(url: String?) {
        if let imageURL = URL(string: url ?? "") {
            Nuke.loadImage(with: imageURL, into: self)
        }
    }
    
}
