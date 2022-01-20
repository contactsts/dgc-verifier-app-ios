//
//  ColorView.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 15/08/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ColorView  : BaseUIView {

    override func initViews() {
//        self.layer.cornerRadius = self.bounds.size.width/2;
//        self.layer.masksToBounds = true
        
//        self.addShadows()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
//        [v.layer setShadowOpacity:0.8];
//        [v.layer setShadowRadius:3.0];
//        [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        //hard-coded this since it's always round
        layer.cornerRadius = 0.5 * bounds.size.width
    }
}
