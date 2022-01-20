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



public class OptionPickerTag : UIView {
    
    
    
    var titleLabel: UILabel!
    var removeIcon: UIView!
    
    
    let disposeBag = DisposeBag()
    
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
        self.backgroundColor = .blue
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        
        titleLabel = UILabel()
        titleLabel.textColor = . black
        self.addSubview(titleLabel)
        
        removeIcon = UIView()
        removeIcon.backgroundColor = .red
        
        
        initLayout()
        bindInput()
        bindOutput()
    }
    
    
    private func initLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        
        removeIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-5)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
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
