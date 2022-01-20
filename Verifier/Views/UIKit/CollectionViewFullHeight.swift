//
//  CollectionViewFullHeight.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 22/08/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewFullHeight: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
