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

public class OptionPickerCell: Cell<[String]>, CellType {
    
    let titleLabel = UILabel()
//    let dummyView = UIView()
    let tagsView = EurekaPickerTagList()
    
    var tagsViewHeightConstraint: Constraint? = nil

    
    public override func setup() {
        super.setup()
        
        selectionStyle = .none
        
        self.backgroundColor = .brown
        titleLabel.text = "xxxx"
        titleLabel.backgroundColor = .magenta
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(10)
        }

        self.contentView.addSubview(tagsView)
        tagsView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5).priority(1000)
            make.top.equalTo(titleLabel.snp.bottom).offset(20).priority(1000)
            
            self.tagsViewHeightConstraint = make.height.equalTo(50).priority(1000).constraint
        }
        
        
        
//        tagsView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        
        // TODO: Find a way to get rid of these default 2 Labels
//        textLabel?.isHidden = true
//        detailTextLabel?.isHidden = true
        
    }
    
    
    open override func didSelect() {
        super.didSelect()
    }
    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
        //        valueLabel.text = row.value ?? "No value"
        
        guard let bounds = self.formViewController()?.tableView.bounds else {
            return
        }
        self.contentView.frame = bounds
        self.contentView.layoutIfNeeded()

     
        
        self.tagsViewHeightConstraint?.update(offset: self.tagsView.collectionView.contentSize.height)
        self.formViewController()?.tableView.beginUpdates()
        self.formViewController()?.tableView.endUpdates()
    }
    
    
}

// The custom Row also has the cell: CustomCell and its correspond value
public final class OptionPickerRow: Row<OptionPickerCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<OptionPickerCell>()
    }
        
    
}
