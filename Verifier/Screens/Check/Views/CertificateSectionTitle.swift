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


class CertificateSectionTitle: UIView {
    
    
    public let titleLabel = UILabel()
    
    init() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        
        super.init(frame: .zero)
        setup()
        
        isAccessibilityElement = false
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
    
    
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        

    }
    

}
