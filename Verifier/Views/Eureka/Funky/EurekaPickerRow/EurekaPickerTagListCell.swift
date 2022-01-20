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



public class EurekaPickerTagListCell : BaseUICollectionViewCell {
    
    // ------------------------- UI ---------------------------
    
        @IBOutlet var xibContent: UIView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var removeImageView: UIImageView!
    
    
//    var titleLabel: UILabel!
//    var removeImageView: UIView!
    
    // ------------------------- PRIVATE ---------------------------
    
    var disposeBag = DisposeBag()
    
    // =========================================================================
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    
    
    // =========================================================================
    
    
    override func initViews() {
        super.initViews()
                initFromXib()
        
                xibContent.layer.cornerRadius = 5
        
        
//        self.backgroundColor = .blue
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor = UIColor.lightGray.cgColor
//
//
//        titleLabel = UILabel()
//        titleLabel.textColor = . black
//        self.contentView.addSubview(titleLabel)
//
//        removeImageView = UIView()
//        removeImageView.backgroundColor = .red
//        self.contentView.addSubview(removeImageView)
        
    }
    
        func initFromXib() {
            let name = String(describing: type(of: self))
            let bundle = Bundle(for: type(of: self))
            bundle.loadNibNamed(name, owner: self, options: nil)
            self.addSubview(xibContent)
            xibContent.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            }
        }
    
    
    override func initLayout() {
//        titleLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(5)
//            make.top.equalToSuperview().offset(5)
//            make.bottom.equalToSuperview().offset(-5)
//        }
//
//
//        removeImageView.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-5)
//            make.width.height.equalTo(20)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
//        }
    }
    
    
    //    private func bindOutput() {
    ////        sortView.rx
    ////            .tapGesture()
    ////            .when(.recognized)
    ////            .subscribe { [weak self]event in
    ////                self?.eventsSubject.onNext(.sort)
    ////        }.disposed(by: disposeBag)
    ////
    ////
    ////        filterView.rx
    ////            .tapGesture()
    ////            .when(.recognized)
    ////            .subscribe { [weak self] event in
    ////                self?.eventsSubject.onNext(.filter)
    ////        }.disposed(by: disposeBag)
    //    }
    
}
