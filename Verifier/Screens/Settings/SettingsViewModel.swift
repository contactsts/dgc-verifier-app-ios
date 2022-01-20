//
//  PlayerEditVM.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/17/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm
import Nuke


class SettingsViewModel {

    var currentLanguage =  BehaviorRelay<String>(value: "en")
    var isFetchingCertificate = BehaviorRelay<Bool>(value: false)
    

    
}
