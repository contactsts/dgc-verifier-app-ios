import UIKit
import Foundation
import SwiftDGC
import RxSwift
import RxCocoa
import RealmSwift

class CertificateRules: UIView {
    
    
    // -------------------- UI -------------------------
    
    private let title = UILabel()
    
    private let tableView = UITableView(frame: .zero)
    
    
    // -------------------- PRIVATE -------------------------
    let realm = try! Realm()
    let disposeBag = DisposeBag()
    
//    let rulesList = BehaviorRelay<Results<RLMRule>?>(value: nil)
//    let filteredRulesList = BehaviorRelay<Results<RLMRule>?>(value: nil)

    
    public var holder: HCertPlus? {
        didSet {
            updateTable()
        }
    }
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    

    
    
    
    private func setupLayout() {
        let padding = 8
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.leading.equalToSuperview().offset(padding)
        }
    }
    
    private func setup() {
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CertificateRuleCell.self, forCellReuseIdentifier: "CertificateRuleCell")
    }
    
    private func updateTable() {
        if holder?.isExternal ?? false {
            title.text = "\(holder?.country?.name ?? " - ") \(UBLocalized.certificate_rules_title_external)"
        } else {
            title.text = "\(CountryManager.sharedInstance.defaultCountry.name!) \(UBLocalized.certificate_rules_title_internal)"
        }
        tableView.reloadData()
    }
    
    
    
}

// CollectionView related methods
extension CertificateRules: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CertLogicEngineManager.sharedInstance.rules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CertificateRuleCell", for: indexPath) as! CertificateRuleCell
  
        let currentRule = CertLogicEngineManager.sharedInstance.rules[indexPath.row]
//        guard let currentRule = CertLogicEngineManager.sharedInstance.rules[indexPath.row] else { return cell }
        cell.isUserInteractionEnabled = false
        
        cell.rule = currentRule
        let currentRuleStatus = holder?.ruleValidationResult.rulesStatus[currentRule.identifier]
        cell.state = currentRuleStatus ?? .open
        
//        cell.state = .open
        
        return cell
    }

}


