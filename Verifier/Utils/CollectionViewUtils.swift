//
//  CollectionViewUtils.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 20/06/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewUtils {
    
    static func getDefaultCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        flowLayout.minimumLineSpacing = 0
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.backgroundColor = UIColor.init(white: 1, alpha: 0)
        collectionView.backgroundColor = .white
//        collectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
        collectionView.alwaysBounceVertical = true;
        return collectionView
    }
    
    static func configureCollectionView(collectionView: UICollectionView) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        flowLayout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true;
    }
    
}
