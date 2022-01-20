//
//  CollectionSeparatorView.swift
//  tomkraina.com
//
//  Created by Tom Kraina on 25.7.2017.
//  Copyright © 2017 Tom Kraina. All rights reserved.
//
import UIKit

class CollectionSeparatorView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        frame = layoutAttributes.frame
    }
}
