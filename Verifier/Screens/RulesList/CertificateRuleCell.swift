//
/*
 * Copyright (c) 2021 Ubique Innovation AG <https://www.ubique.ch>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * SPDX-License-Identifier: MPL-2.0
 */

import Foundation
import UIKit
import RxSwift
import CertLogic

class CertificateRuleCell: BaseUITableViewCell {
    
    @IBOutlet var xibContent: UIView!
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var ruleSection: RuleTitleValueView!


    
    
    var rule: CertLogic.Rule? {
        didSet {
            guard let rule = rule else { return }
            ruleSection.titleLabel.text = UBLocalized.certificate_rules_section_rule
            ruleSection.descriptionLabel.text = rule.description.first?.desc
        }
    }
    
    var state: CertLogic.Result = .open {
        didSet {
            switch state {
            case .open:
                statusImageView.isHidden = true
                statusLabel.isHidden = true
                xibContent.backgroundColor = UIColor.init(hexString: "#eeeeee")
            case .fail:
                statusImageView.isHidden = false
                statusLabel.isHidden = false
                xibContent.backgroundColor = UIColor.init(hexString: "#F7E6EC")
                statusImageView.image = UIImage(named: "ic-info-alert")
                statusLabel.text = UBLocalized.certificate_rules_status_failed
                statusLabel.textColor = UIColor(hexString: "#C7365C")
            case .passed:
                statusImageView.isHidden = false
                statusLabel.isHidden = false
                xibContent.backgroundColor = UIColor.init(hexString: "#E5F4F1")
                statusImageView.image = UIImage(named: "ic-rule-passed")
                statusLabel.text = UBLocalized.certificate_rules_status_passed
                statusLabel.textColor = UIColor(hexString: "#60BBA7")
            }
        }
    }
    
    
    
    
    var disposeBag = DisposeBag()
    
    // ---------------------------------------------
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.cellInit()
//    }
    
    override func initViews() {
        super.initViews()
        
        Bundle.main.loadNibNamed("CertificateRuleCell", owner: self, options: nil)
        self.contentView.addSubview(xibContent)
        xibContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
        
        xibContent.layer.cornerRadius = 10
        xibContent.layer.masksToBounds = true
        xibContent.backgroundColor = UIColor.init(hexString: "#eeeeee")
    }
    
    
    

    
}
