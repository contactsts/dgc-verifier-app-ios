//
//  PlayersListVC.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 7/28/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import SwipeCellKit



class CountryPickerVC: BaseViewController {
    
    // ------------------------- UI ---------------------------
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    

    
    
    // ------------------------- PRIVATE ---------------------------
    
    
    
    var viewModel = CountryPickerVM(countries: nil)
    let disposeBag = DisposeBag()

    
    // ------------------------- PUBLIC ---------------------------

    let result = BehaviorRelay<FLCountry?>(value: nil)

    // ===========================================================================================

    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    
    // ===========================================================================================
    

    override func initViews() {
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
    }

    // ===========================================================================================

    override func initLayout() {

    }

    // ===========================================================================================

    override func bindToViewModel() {
        searchTextField.rx.text
                .orEmpty
                .debounce(RxTimeInterval.milliseconds(10), scheduler: MainScheduler.instance)
                .subscribe { event in
                    self.viewModel.filterText.accept(event.element!)
        }.disposed(by: disposeBag)
    }

    // ===========================================================================================

    override func bindFromViewModel() {
        viewModel.filtertedList.subscribe { [weak self] event in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }

    // ===========================================================================================


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.placeholder = UBLocalized.country_picker_search_placeholder
        title = UBLocalized.country_picker_title
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}



// CollectionView related methods
extension CountryPickerVC: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filtertedList.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
    
//        guard let currentItem = viewModel.filtertedList.value[indexPath.row] else {
//            return cell
//        }
        
        let country = viewModel.filtertedList.value[indexPath.row]
        
        
        guard let countryCode = country.code?.uppercased() else { return cell }
        let countryCodesWithRules = viewModel.countryCodesWithRules.value
        let countryRulesCount = countryCodesWithRules.keys.contains(countryCode) ? countryCodesWithRules[countryCode] : 0
        
        cell.country = country
        cell.rulesCount = countryRulesCount ?? 0
        
//        cell.country = "\(country) (\(countryRulesCount)"
        
//        let isContained = countryCodesWithRules.contains(where: {$0.uppercased() == currentItem.code?.uppercased() })
//        cell.isMuted = (countryRulesCount == 0)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentItem = viewModel.filtertedList.value[indexPath.row]
        self.result.accept(currentItem)
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

}


