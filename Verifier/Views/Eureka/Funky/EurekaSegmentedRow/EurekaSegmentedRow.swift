//
//  ImageRow.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/17/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import Eureka
import SnapKit
import RxSwift
import RxCocoa

//public class EurekaSegmentedCell<T: Equatable>: Cell<T>, CellType {
  
public class EurekaSegmentedCell: BaseEurekaCell<EurekaSegmentedRowOption> {
    
    // ---------------------------- UI -----------------------------
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // ------------------------- PRIVATE ---------------------------
    
    var rowCasted: EurekaSegmentedRow!
    
    // ==============================================================
    
    
    
    override func initViews() {
        rowCasted = (row as! EurekaSegmentedRow)
    }
    


    
    override func initBindings() {
        super.initBindings()
        
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { value in
            if value > self.rowCasted.options.count - 1 {
                return
            }
            
            let selectedOption = self.rowCasted.options[value]
            if (selectedOption.name != self.rowCasted.onResult.value?.name) {
                self.rowCasted.value = selectedOption
            }
        }).disposed(by: disposeBag)
        
        
        rowCasted.onResult.skip(1).subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            //            print("EurekaTextRow.onResult \(self.rowCasted.title) \(self.rowCasted.value)")
            
            if self.rowCasted.value != value {
                self.rowCasted.value = value
            }
        }).disposed(by: disposeBag)
    }
    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
        titleLabel.isHidden = !rowCasted.showTitle
        
//        updateSegmentedControl()

        segmentedControl.selectedSegmentIndex = selectedIndex() ?? UISegmentedControl.noSegment
        segmentedControl.isEnabled = !row.isDisabled
    }
    
    
//    @objc func valueChanged() {
//        let value = (row as! EurekaSegmentedRow<T>).options[segmentedControl.selectedSegmentIndex]
//        rowCasted.onResult.accept(value)
////        row.value = (row as! EurekaSegmentedRow<T>).options[segmentedControl.selectedSegmentIndex]
//    }
    
    
    func updateSegmentedControl() {
        segmentedControl.removeAllSegments()
        
        rowCasted.options.reversed().forEach {
            if let image = $0 as? UIImage {
                segmentedControl.insertSegment(with: image, at: 0, animated: false)
            } else {
                segmentedControl.insertSegment(withTitle: $0.name, at: 0, animated: false)
            }
        }
    }
    
    
    func selectedIndex() -> Int? {
        guard let value = row.value else { return nil }
        return rowCasted.options.firstIndex(of: value)
    }
    
    
    
    
}

// The custom Row also has the cell: CustomCell and its correspond value
//public final class EurekaSegmentedRow<T: Equatable>: Row<EurekaSegmentedCell<T>>, RowType {
//public final class EurekaSegmentedRow<T: Equatable>: BaseEurekaRow<EurekaSegmentedCell<T>, T>, RowType  {

public final class EurekaSegmentedRow: BaseEurekaRow<EurekaSegmentedCell, EurekaSegmentedRowOption>, RowType {
    
    public required init(tag: String?) {
        super.init(tag: tag)
        onResult2 = onResult.asObservable()
    }
    
    var options: [EurekaSegmentedRowOption] = [] {
        didSet {
            cell.updateSegmentedControl()
        }
    }
    
    
    var showTitle: Bool = true {
        didSet {
            updateCell()
        }
    }
    
    public override var value: Cell.Value? {
        didSet {
            if oldValue != value {
                onResult.accept(value)
//                updateCell()
            }
        }
    }
    
    let onResult = BehaviorRelay<EurekaSegmentedRowOption?>(value: nil)
    var onResult2: Observable<EurekaSegmentedRowOption?>! = nil
    
    
    


}


public struct EurekaSegmentedRowOption : Equatable {
    var id: Any
    var name: String
    
    public static func == (lhs: EurekaSegmentedRowOption, rhs: EurekaSegmentedRowOption) -> Bool {
        return lhs.name == rhs.name
    }
}
