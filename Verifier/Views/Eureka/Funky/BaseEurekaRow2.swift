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


protocol SetupProtocol {
    var isSetuped : Bool {get set}
}


public class BaseEurekaCell2<TCellData>: Cell<TCellData>, CellType, SetupProtocol where TCellData: Equatable {
    
    
//    let castedRow:
    let disposeBag = DisposeBag()
    var isSetuped = false
    
    

    public override func setup() {
        super.setup()
        isSetuped = true

        
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



open class BaseEurekaRow2<TCell>: Row<TCell> where TCell : BaseCell, TCell : CellType {
//open class BaseEurekaRow2<TCell>: Row<TCell> where TCell : BaseEurekaCell2{
    
    required public init(tag: String?) {
        super.init(tag: tag)
        let xibName = String(describing: TCell.self)
        cellProvider = CellProvider<TCell>(nibName: xibName)
    }
    
//    public override var value: Cell.Value? {
//        didSet {
//
//        }
//    }

}
