//
//  CircleImageView.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 20.03.2021.
//  Copyright © 2021 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit


class CircleImageView: UIImageView {

    override init(frame: CGRect) {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
    }

    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        // 3. Setup view from .xib file
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 0
//        self.layer.borderColor = UIColor.red.cgColor
        self.layer.masksToBounds = false
//        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
