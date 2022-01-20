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

class RulesListViewModel {
    
    
    // ------------------------- RX ---------------------------

    
    let isLoading = BehaviorRelay<Bool>(value: true)
//    let filterText = BehaviorRelay<String>(value: "")
    
    let country = BehaviorRelay<FLCountry>(value: CountryManager.sharedInstance.defaultCountry)
    
    let rulesList = BehaviorRelay<Results<RLMRule>?>(value: nil)
    let filteredRulesList = BehaviorRelay<Results<RLMRule>?>(value: nil)
    
    
    // ----------------------- PRIVATE --------------------------
    
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    

    
    
    // ==========================================================
    
    
    init () {
        let list = realm.objects(RLMRule.self)
        
        Observable.collection(from: list)
            .subscribe { event in
                self.rulesList.accept(event.element)
                self.applyFilter()
        }
        .disposed(by: disposeBag)
        
//        pageList.subscribe {event in
//            self.applyFilter()
//        }
//        .disposed(by: disposeBag)
        
        country.subscribe {event in
            self.applyFilter()
        }
        .disposed(by: disposeBag)
    }
    
    private func applyFilter() {
        let list = rulesList.value
        let currentCountry = country.value

        if list == nil {
            filteredRulesList.accept(nil)
            return
        }

        if currentCountry == nil {
            filteredRulesList.accept(nil)
            return
        }

        let filterPredicate = NSPredicate(format: "countryCode = %@ AND isNational = false", currentCountry.code!.uppercased())
        filteredRulesList.accept(list!.filter(filterPredicate))
    }
    
    

    
    
    
}

