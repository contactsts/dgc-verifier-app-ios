//
//  BaseEurekaRow.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 07/10/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import Eureka
import RxSwift



public class BaseEurekaCell<TCellData>: Cell<TCellData>, CellType where TCellData: Equatable {
    
    
//    let castedRow:
    let disposeBag = DisposeBag()
    
    

    public override func setup() {
        super.setup()

        initViews()
        initLayout()
        initBindings()
    }
    

    
    
    func initViews() {
        selectionStyle = .none
        
        // TODO: Find a way to get rid of these default 2 Labels
        textLabel?.isHidden = true
        detailTextLabel?.isHidden = true
    }
    
    
    func initLayout() {
        
    }
    
    
    func initBindings() {
        
    }
    
    
    public override func update() {
        super.update()
        self.formViewController()?.tableView.beginUpdates()
        self.formViewController()?.tableView.endUpdates()
    }
    
    
    
    
}



//public final class EurekaDoubleTextRow: Row<EurekaDoubleTextCell>, RowType {
//open class BaseEurekaRow<T,S>: Row<T> where T: BaseEurekaCell<S> {
open class BaseEurekaRow<TCell,TCellData>: Row<TCell> where TCell: BaseEurekaCell<TCellData> {
    
    
    public var hiddenRow: Bool = false {
        didSet {
            hidden = hiddenRow ? false : true
            evaluateHidden()
        }
    }
    
//    public override var hidden: Condition? {
//        didSet {
//            evaluateHidden()
//        }
//    }
    
//    var hidden: String? {
//        didSet {
//            self.updateCell()
//        }
//    }
    
    required public init(tag: String?) {
        super.init(tag: tag)
        var xibName = String(describing: TCell.self)
    
//        var xibName2 = xibName.replacingOccurrences(of: "\\<.*>\\]", with: "", options: .regularExpression)
        var xibName2 = String(xibName.split(separator: "<")[0])
        
        cellProvider = CellProvider<TCell>(nibName: xibName)
    }


}

