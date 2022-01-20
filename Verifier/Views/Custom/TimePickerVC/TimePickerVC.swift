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


struct TimeData {
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    
    func toSeconds() -> Int {
        return hour * 3600 + minutes * 60 + seconds
    }
}

class TimePickerVC : BaseViewController, PanModalPresentable {
    
    // ---------------------------- UI ---------------------------
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    // ------------------------- PRIVATE -------------------------
    
    var timeData = TimeData()
    
    let disposeBag = DisposeBag()
    let result = PublishSubject<TimeData>()
    
    // ===========================================================================================
    
    override func initViews() {
        pickerView.delegate = self
    }
    
    
    override func initLayout() {

    }
    
    override func bindToViewModel() {
        doneButton.rx.tap.subscribe(onNext: { _ in
//            self.result.onNext(self.datePicker.date)
            self.result.onNext(self.timeData)
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
//        datePicker.date = initialDate
    }
}


extension TimePickerVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 50
        case 1,2:
            return 60

        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(format:"%02i", row) + "H"
        case 1:
            return String(format:"%02i", row) + "m"
        case 2:
            return String(format:"%02i", row) + "s"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            timeData.hour = row
        case 1:
            timeData.minutes = row
        case 2:
            timeData.seconds = row
        default:
            break;
        }
    }
}


