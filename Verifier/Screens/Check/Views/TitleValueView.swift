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



class TitleValueView: UIView {
    public let titleLabel: Label
    public let descriptionLabel: Label
    
    init(labelTypeTitle: LabelType = .textBoldLarge, labelTypeDescription: LabelType = .text ) {
        titleLabel = Label(labelTypeTitle)
        descriptionLabel = Label(labelTypeDescription)
        super.init(frame: .zero)
        setup()

        isAccessibilityElement = true
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(1.0)
            make.bottom.left.right.equalToSuperview()
        }
        

    }
    
    override var accessibilityLabel: String? {
        get { return [descriptionLabel.accessibilityLabel, titleLabel.accessibilityLabel].compactMap { $0 }.joined(separator: ", ") }
        set { super.accessibilityLabel = newValue }
    }
}
