//
//  GradientView.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 09/03/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientView: UIView {
    
    
    var gradientColorsList: [CGColor] = []
    
    init(gradientColorsList: [CGColor]) {
        super.init(frame: .zero)
        self.gradientColorsList = gradientColorsList
//        loadViewFromNib()
        initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    
    private func initViews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = gradientColorsList
//        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
    }
    
    
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }
    
}
