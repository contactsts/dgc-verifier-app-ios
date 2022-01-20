//
//  NavigationBarDetails.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 05/08/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxGesture


struct NavigationBarDetailsActionItem {
    var code: String
    var name: String?
    var image: String?
}


//@IBDesignable
class NavigationBarDetails : UIView, UIViewGuide {
    
    
    // ------------------------- UI ---------------------------
    @IBOutlet var xibContent: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionsStackView: UIStackView!
    
    // ------------------------- PRIVATE ---------------------------

    let disposeBag = DisposeBag()

    var actionItemsList: [NavigationBarDetailsActionItem] = [] {
        didSet {
            actionsStackView.removeAllArrangedSubviews()
            for currentActionItem in actionItemsList {
//                let titleLabel = UILabelUtils.getEurekaTitleLabel()
//                titleLabel.text = currentActionItem.name
                
                let titleLabel = FunkyButton(frame: .zero)
                titleLabel.titleLabel.text = currentActionItem.name
                
                
                titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                actionsStackView.addArrangedSubview(titleLabel)
                
                titleLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
                    self?.result.onNext(currentActionItem)
                }).disposed(by: disposeBag)
            }
        }
    }
    
    let result = PublishSubject<NavigationBarDetailsActionItem>()
    
    
    // ------------------------------------------
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cellInit()
    }
    
    
    func cellInit() {
        initFromXib()
        self.initViews()
        self.initLayout()
        self.initBindings()
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
    
    func initViews() {

    }
    
    func initLayout() {

    }
    
    func initBindings() {
        
    }
    
}
