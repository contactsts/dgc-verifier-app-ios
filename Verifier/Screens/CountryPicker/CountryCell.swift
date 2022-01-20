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

class CountryCell: BaseUITableViewCell {
    
    @IBOutlet var xibContent: UIView!
    

    @IBOutlet weak var flagLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var country: FLCountry? {
        didSet {
            guard let country = country else { return }
            flagLabel.text = country.flag
            nameLabel.text = "\(country.name!) (\(rulesCount)"
        }
    }
    
    var isMuted : Bool = false {
        didSet {
            let alpha = isMuted ? 0.3 : 1.0
            nameLabel.alpha = alpha
            flagLabel.alpha = alpha
        }
    }
    
    var rulesCount : Int = 0 {
        didSet {
            guard let country = country else { return }
            
            let alpha = rulesCount == 0 ? 0.3 : 1.0
            nameLabel.alpha = alpha
            flagLabel.alpha = alpha
            nameLabel.text = "\(country.name!) (\(rulesCount))"
        }
    }
    
    
    
    
    var disposeBag = DisposeBag()
    
    // ---------------------------------------------
    
    
    override func initViews() {
        super.initViews()
        
        Bundle.main.loadNibNamed("CountryCell", owner: self, options: nil)
        self.contentView.addSubview(xibContent)
        xibContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
    }
    
    
    
    
}
