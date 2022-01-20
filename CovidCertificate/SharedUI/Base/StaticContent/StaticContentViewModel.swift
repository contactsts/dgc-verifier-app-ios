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

import UIKit

struct StaticContentViewModel: Equatable {
    let heading: String?
    let foregroundImage: UIImage?
    let title: String
    let alignment: NSTextAlignment
    let textGroups: [(UIImage?, String)]
    let expandableTextGroups: [(String, String, String?, URL?)]

    init(heading: String? = nil,
         foregroundImage: UIImage? = nil,
         title: String,
         alignment: NSTextAlignment = .left,
         textGroups: [(UIImage?, String)] = [],
         expandableTextGroups: [(String, String, String?, URL?)] = [])
    {
        self.heading = heading
        self.foregroundImage = foregroundImage
        self.title = title
        self.alignment = alignment
        self.textGroups = textGroups
        self.expandableTextGroups = expandableTextGroups
    }

    static func == (lhs: StaticContentViewModel, rhs: StaticContentViewModel) -> Bool {
        return lhs.heading == rhs.heading &&
            lhs.foregroundImage == rhs.foregroundImage &&
            lhs.title == rhs.title &&
            lhs.alignment == rhs.alignment &&
            lhs.textGroups.elementsEqual(rhs.textGroups) {
                $0.0 == $1.0 && $0.1 == $1.1
            } && lhs.expandableTextGroups.elementsEqual(rhs.expandableTextGroups) {
                $0.0 == $1.0 && $0.1 == $1.1 && $0.2 == $1.2 && $0.3 == $1.3
            }
    }


}
