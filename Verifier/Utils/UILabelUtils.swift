//
//  TextUtils.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 22/06/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

class UILabelUtils {
    
    static func getTitleLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }
    
    static func getSubtitleLabel() -> UILabel {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return view
    }
    
    static func getSmallLabel() -> UILabel {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return view
    }
    
    
    static func getCountLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return view
    }
    
    // ------------------------------------------
    
    static func getEurekaTitleLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return view
    }
    
    
    static func getEurekaValueLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return view
    }
    
    
    static func getEurekaHintLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        view.numberOfLines = 0
        return view
    }
    
    
    static func getEurekaErrorLabel() -> UILabel {
        let view = UILabel()
        view.textColor = .red
        view.font = UIFont.systemFont(ofSize: 12)
        view.numberOfLines = 0
        return view
    }
}
