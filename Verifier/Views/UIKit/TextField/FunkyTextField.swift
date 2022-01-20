//
//  FunkyTextField.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 07/10/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

class FunkyTextField : UITextField, UIViewGuide {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    func initViews() {
        self.borderStyle = .none
        self.clearButtonMode = .always
        self.placeholder = "Type something..."
        self.backgroundColor = UIColor(hexString: "#eeeeee")
        self.setLeftPadding()
        self.layer.cornerRadius = 5
    }
    
    func initLayout() {
        
    }
    
    func initBindings() {
        
    }
    
}
