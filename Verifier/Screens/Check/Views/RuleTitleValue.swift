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



class RuleTitleValueView: UIView {
    public let titleLabel: Label
    public let descriptionLabel: Label
    
    init(labelTypeTitle: LabelType = .textBold, labelTypeDescription: LabelType = .text ) {
        titleLabel = Label(labelTypeTitle)
        descriptionLabel = Label(labelTypeDescription)
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        super.init(frame: .zero)
        setup()

        isAccessibilityElement = true
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        
        titleLabel = Label(.textBold)
        descriptionLabel = Label(.text)
        super.init(frame: .zero)
        setup()

        isAccessibilityElement = true
        
//        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(1.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        

        

    }
    
    override var accessibilityLabel: String? {
        get { return [descriptionLabel.accessibilityLabel, titleLabel.accessibilityLabel].compactMap { $0 }.joined(separator: ", ") }
        set { super.accessibilityLabel = newValue }
    }
}
