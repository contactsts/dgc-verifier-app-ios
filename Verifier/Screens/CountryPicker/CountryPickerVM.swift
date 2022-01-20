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

class CountryPickerVM {
    
    
    // ------------------------- RX ---------------------------
    
    
    
    
    let isLoading = BehaviorRelay<Bool>(value: true)
    let filterText = BehaviorRelay<String>(value: "")
    

    
    let countriesList = BehaviorRelay<[FLCountry]>(value: [])
    let filtertedList = BehaviorRelay<[FLCountry]>(value: [])
    
    let rulesList = BehaviorRelay<Results<RLMRule>?>(value: nil)
    let countryCodesWithRules = BehaviorRelay<[String : Int]>(value: [:])
    
    
    // ----------------------- PRIVATE --------------------------
    
//    let realm = try! Realm()
    let disposeBag = DisposeBag()
    


    // ==========================================================
    
    
    init (countries : [FLCountry]?) {
        let realm = try! Realm()
        let allCountries = CountryManager.sharedInstance.countriesListForRules
        
        
        let rlmRulesList = realm.objects(RLMRule.self).filter("isNational = false")
        Observable.collection(from: rlmRulesList)
            .subscribe { event in
                self.rulesList.accept(event.element)
                self.buildCountryCodesWithRules()
        }
        .disposed(by: disposeBag)

        
        let rlmCountriesList = realm.objects(RLMCountry.self)
        Observable.collection(from: rlmCountriesList)
            .subscribe { event in
//                self.buildCountryCodesWithRules()
        }
        .disposed(by: disposeBag)
        let availableCountryCodes = rlmCountriesList.toArray()
        let availableCountries = allCountries.filter { currentFLCountry in
            return availableCountryCodes.contains(where: { currentCountyCode in
                return currentCountyCode.countryCode?.uppercased() == currentFLCountry.code?.uppercased()
            })
        }
        countriesList.accept(availableCountries)
        

        
        filterText.subscribe { event in
            self.applyFilter()
        }
        .disposed(by: disposeBag)
    }
    
    private func applyFilter() {
        let list = countriesList.value
        let filter = filterText.value

        if list == nil {
            filtertedList.accept([])
            return
        }

        if filter.count == 0 {
            filtertedList.accept(list)
            return
        }

//        let filterPredicate = NSPredicate(format: "name CONTAINS[c] %@", filter)
//        filtertedList.accept(list!.filter(filterPredicate))
        filtertedList.accept(list.filter { $0.name!.range(of: filter, options: .caseInsensitive) != nil })
    }
    
    
    private func buildCountryCodesWithRules() {
        let list = rulesList.value
        
        if list == nil {
            countryCodesWithRules.accept([:])
            return
        }
        
//        let result = list!.toArray().map { $0.countryCode }.compactMap{ $0 }.uniqued()
        
        let dictionary = Dictionary(grouping: list!, by: { $0.countryCode! })
            .mapValues { value in
                return value.count
            }

        countryCodesWithRules.accept(dictionary)
    }
    
    
    
}

