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



class RulesListViewController: BaseViewController {
    
    
    
    // ------------------------- UI ---------------------------
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var countryPickerLabel: UILabel!
    @IBOutlet weak var countrySelectView: CountryPickerView!
    
    
    
    // ------------------------- PRIVATE ---------------------------
    
    
    
    var viewModel = RulesListViewModel()
    let disposeBag = DisposeBag()


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

        tableView.register(RuleCell.self, forCellReuseIdentifier: "RuleCell")
        
//        CollectionViewUtils.configureCollectionView(collectionView: collectionView)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(RuleCell.self, forCellWithReuseIdentifier: "RuleCell")
    }

    // ===========================================================================================

    override func initLayout() {

    }

    // ===========================================================================================

    override func bindToViewModel() {
//        searchField.searchTextField.rx.text
//                .orEmpty
//                .debounce(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
//                .subscribe { event in
//                    self.viewModel.filterText.accept(event.element!)
//        }.disposed(by: disposeBag)
 
        
    
        
        countrySelectView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.onCountryChange()
        }).disposed(by: disposeBag)
        

    }

    // ===========================================================================================

    override func bindFromViewModel() {
        
        
//        viewModel.filteredRulesList.subscribe(onNext : { value in
//        viewModel.filteredRulesList.subscribe { [weak self] event in
//            self?.tableView.reloadData()
//            self?.subtitleStackViewLabel.text = "\(value.count ?? 0) \(UBLocalized.rules_list_subtitle)"
//        }.disposed(by: disposeBag)
        
        
        viewModel.filteredRulesList.subscribe(onNext: { [weak self] list in
            self?.tableView.reloadData()
            self?.subtitleStackViewLabel.text = "\(list?.count ?? 0) \(UBLocalized.rules_list_subtitle)"
        }).disposed(by: disposeBag)
        
        
        viewModel.country.subscribe(onNext: { [weak self] country in
            self?.countrySelectView.country = country
        }).disposed(by: disposeBag)

    }

    // ===========================================================================================

        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.countryPickerLabel.text = UBLocalized.rules_list_select_a_country
        title = UBLocalized.rules_list_title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}



// CollectionView related methods
extension RulesListViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredRulesList.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuleCell", for: indexPath) as! RuleCell
    
        guard let currentItem = viewModel.filteredRulesList.value?[indexPath.row] else {
            return cell
        }
        cell.isUserInteractionEnabled = false
        
        cell.rule = currentItem
        return cell
    }

}


extension RulesListViewController {
    func onCountryChange() {
        let countryPickerVC = CountryPickerVC()
        
        self.navigationController?.pushViewController(countryPickerVC, animated: true)
                
        countryPickerVC.result.subscribe(onNext: { [weak self] value in
            guard let value = value else { return }
            self?.countrySelectView.country = value
            self?.viewModel.country.accept(value)
        }).disposed(by: disposeBag)
    }
}
