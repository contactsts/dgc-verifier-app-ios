//
//  FilterSortHorizontalBar.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 12/22/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxGesture
import RxCocoa


public class EurekaPickerTagList : UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // ------------------------- UI ---------------------------
    
    lazy var collectionView : CollectionViewFullHeight = {
//        let layout = UICollectionViewFlowLayout()
        let layout = UICollectionViewLeftAlignedLayout()
//        layout.estimatedItemSize = CGSize.init(width: 1, height: 1)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = CollectionViewFullHeight(frame: CGRect.zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(EurekaPickerTagListCell.self, forCellWithReuseIdentifier: "EurekaPickerTagListCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    
    // ------------------------- PRIVATE ---------------------------
    
    var selectedItems : [GenericPickerItem] = [] {
        didSet {
//            collectionView.reloadData()
            result.accept(selectedItems)
        }
    }
    let disposeBag = DisposeBag()
    
    let result = BehaviorRelay<[GenericPickerItem]>(value: [])
    
    // =========================================================================
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    
    // =========================================================================
    
    
    private func initViews() {
//        self.backgroundColor = .green
        
        addSubview(collectionView)
        
        
        initLayout()
        bindInput()
        bindOutput()
    }
    
    
    private func initLayout() {
        
        collectionView.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.top.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().offset(-20)
//            make.trailing.equalToSuperview().offset(-20)
            
            make.leading.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
        }
        
    }
    
    
    private func bindInput() {
        
    }
    
    
    private func bindOutput() {
        //        sortView.rx
        //            .tapGesture()
        //            .when(.recognized)
        //            .subscribe { [weak self]event in
        //                self?.eventsSubject.onNext(.sort)
        //        }.disposed(by: disposeBag)
        //
        //
        //        filterView.rx
        //            .tapGesture()
        //            .when(.recognized)
        //            .subscribe { [weak self] event in
        //                self?.eventsSubject.onNext(.filter)
        //        }.disposed(by: disposeBag)
    }
    
}


public extension EurekaPickerTagList {
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EurekaPickerTagListCell", for: indexPath) as! EurekaPickerTagListCell
        let currentItem = selectedItems[indexPath.row]
//        cell.backgroundColor = .cyan
        
//        let fraction = Int.random(in: 0 ..< 100000000)
//        cell.titleLabel.text = "Nr  \(fraction)"
        cell.titleLabel.text = currentItem.title
        cell
//            .removeImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.onRemoveItem(indexPath: indexPath)
            }).disposed(by: cell.disposeBag)
        
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width, height: 200)
//    }
}

extension EurekaPickerTagList {
    
    func onRemoveItem(indexPath: IndexPath) {        
        self.collectionView.performBatchUpdates({
            self.selectedItems.remove(at: indexPath.row)
            self.collectionView.deleteItems(at:[indexPath])
        }, completion: { _ in
            self.collectionView.reloadData()
        })
        
        
//        self.selectedItems = selectedItems
//        selectedItems.remove(at: indexPath.row)
//        collectionView.reloadData()
    }
    
}

