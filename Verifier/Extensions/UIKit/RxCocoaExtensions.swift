//
//  RxCocoaExtensions.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 14.03.2021.
//  Copyright © 2021 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


extension UIView {
    
    func rxTap() -> Observable<UITapGestureRecognizer> {
        return self.rx
            .tapGesture()
            .when(.recognized)
            .asObservable()
//            .asObservable().map { (event) -> Void in
//                return Void
//            }
        
//            .subscribe { event in
//                self.viewModel.selectNone()
//        }
    }
    
}



