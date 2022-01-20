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

class RuleCell: BaseUITableViewCell {
    
    @IBOutlet var xibContent: UIView!
    

    @IBOutlet weak var identifierSection: RuleTitleValueView!
    
    @IBOutlet weak var certificateTypeSection: RuleTitleValueView!
    
    @IBOutlet weak var descriptionSection: RuleTitleValueView!
    
    @IBOutlet weak var validFromSection: RuleTitleValueView!
    
    @IBOutlet weak var validToSection: RuleTitleValueView!
    
    var rule: RLMRule? {
        didSet {
            guard let rule = rule else {
                return
            }
            identifierSection.titleLabel.text = UBLocalized.rule_title_identifier
            identifierSection.descriptionLabel.text = rule.identifier
            
            certificateTypeSection.titleLabel.text = UBLocalized.rule_title_certificate_type
            certificateTypeSection.descriptionLabel.text = rule.certificateType
            
            descriptionSection.titleLabel.text = UBLocalized.rule_title_description
            descriptionSection.descriptionLabel.text = rule.displayName
            
            validFromSection.titleLabel.text = UBLocalized.rule_title_valid_from
            validFromSection.descriptionLabel.text = rule.validFrom != nil ? DateUtils.formatDateToString(date: rule.validFrom!) : " - "
            
            validToSection.titleLabel.text = UBLocalized.rule_title_valid_to
            validToSection.descriptionLabel.text = rule.validTo != nil ? DateUtils.formatDateToString(date: rule.validTo!) : " - "
        }
    }
    
    var state: CertLogic.Result = .open {
        didSet {
            switch state {
            case .open:
                xibContent.backgroundColor = UIColor.init(hexString: "#eeeeee")
            case .fail:
                xibContent.backgroundColor = UIColor.init(hexString: "#ff0000")
            case .passed:
                xibContent.backgroundColor = UIColor.init(hexString: "#00ff00")
            }
        }
    }
    
    
    
    
    var disposeBag = DisposeBag()
    
    // ---------------------------------------------
    
    
    override func initViews() {
        super.initViews()
        
        
        
        Bundle.main.loadNibNamed("RuleCell", owner: self, options: nil)
        self.contentView.addSubview(xibContent)
        xibContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
        
        xibContent.layer.cornerRadius = 10
        xibContent.layer.masksToBounds = true
        xibContent.backgroundColor = UIColor.init(hexString: "#eeeeee")
    }
    
    
    
    
    enum RuleCellState {
        case nothing
        case success
        case failed
    }
    
}
