//
//  TextDialog.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 03/06/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import UIKit
import SnapKit
import Foundation
import RxSwift



struct TextDialogVCInput {
    var title: String
    var subtitle: String
    var value: String
}

class TextDialogVC: BaseViewController {
    
    
    var textDialogVCInput: TextDialogVCInput
    
    var value: String = ""
    
    
    let textField: UITextView = {
        let view  = UITextView()
        view.isEditable = true
        //            view.borderStyle = .roundedRect
        return view
    }()
    
    
    
    var saveBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Save", style: .done, target: nil, action: nil)
        return view
    }()
    
    let resultStream = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    // ===========================================================================================
    
    
    
    //    init(title: String, value: String) {
    init(textDialogVCInput: TextDialogVCInput) {
        self.textDialogVCInput = textDialogVCInput
        self.value = textDialogVCInput.value
        self.textField.text = value
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    
    // ===========================================================================================
    
    override func initViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(textField)
    }
    
    override func initLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    override func bindToViewModel() {
        saveBarButton.rx.tap.subscribe { [weak self] event in
            guard let self = self else { return }
            
            self.resultStream.onNext(self.textField.text ?? "")
            
        }.disposed(by: disposeBag)
    }
    
    override func bindFromViewModel() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleStackViewLabel.text = textDialogVCInput.title
        subtitleStackViewLabel.text = textDialogVCInput.subtitle
        
        navigationItem.rightBarButtonItem = saveBarButton
        textField.becomeFirstResponder()
    }
    
}
