//
//  GamesListVM.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 7/28/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class ColorPickerVM {

    let realm = try! Realm()
    
    let colorsList = BehaviorRelay<[MaterialColor]>(value: [])
    let selectedColor = BehaviorRelay<MaterialColor?>(value: nil)
    
    let disposeBag = DisposeBag()

    // ==========================================================


    init(selectedColor: MaterialColor? = nil) {
        colorsList.accept(MaterialColorsManager.colorsList)
        self.selectedColor.accept(selectedColor)
    }

    // ==========================================================




}
