//
//  DatePickerVC.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 15/08/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import PanModal
import RxSwift



class DatePickerVC : BaseViewController, PanModalPresentable {
    
    // ---------------------------- UI ---------------------------
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // ------------------------- PRIVATE -------------------------
    
    var initialDate = Date() {
        didSet {
//            datePicker.date = initialDate
        }
    }
    let disposeBag = DisposeBag()
    let result = PublishSubject<Date>()
    
    // ===========================================================================================
    
    override func initViews() {
//        self.view.backgroundColor = .white
//        self.view.addSubview(datePicker)
        datePicker.datePickerMode = .date
    }
    
    
    override func initLayout() {

    }
    
    override func bindToViewModel() {
        doneButton.rx.tap.subscribe(onNext: { _ in
            self.result.onNext(self.datePicker.date)
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        datePicker.date = initialDate
    }
}


