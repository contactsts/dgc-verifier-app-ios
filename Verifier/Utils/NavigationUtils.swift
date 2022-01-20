//
//  NavigationUtils.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 1/5/20.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

class NavigationUtils {
    
    static func presentViewController(sourceVC: UIViewController, destinationVC: UIViewController, modally: Bool) {
        if modally {
            if #available(iOS 13.0, *) {
                destinationVC.isModalInPresentation = true // available in IOS13
            } else {
                destinationVC.modalPresentationStyle = .fullScreen
            }
        }
        sourceVC.present(destinationVC, animated: true, completion: nil)
    }
    
}
