//
//  EurekaUtils.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 14/07/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import Eureka


class EurekaUtils {


    static var showAdvancedViewOptions = [
        EurekaSegmentedRowOption(id: false, name: "Basic"),
        EurekaSegmentedRowOption(id: true, name: "Advanced"),
    ]
    
    static func addRequiredRuleCount(eurekaLabelRow: EurekaLabelRow, list: [Any]) {
        let ruleRequiredViaClosure = RuleClosure<String> { rowValue in
            return list.count == 0 ? Eureka.ValidationError(msg: "Field required!") :  nil
        }
        eurekaLabelRow.add(rule: ruleRequiredViaClosure)
    }
    
    static func isFormValid(formViewController: FormViewController) -> Bool {
//        formViewController.tableView.beginUpdates()
//        formViewController.tableView.endUpdates()
        let errors = formViewController.form.validate()
        formViewController.tableView.beginUpdates()
        formViewController.tableView.endUpdates()
        
        return errors.count == 0
    }
    
}


// =================================== RULES ===============================================


public struct RuleArrayNotEmpty: RuleType {
    public typealias RowValueType = String
    

    public var id: String?
    public var validationError: Eureka.ValidationError

//    public var closure: ([Any]) -> ValidationError?
     public var closureGetList: () -> [Any]

    public func isValid(value: String?) -> Eureka.ValidationError? {
        let list = closureGetList()
        return list.count == 0 ? validationError :  nil
    }

    public init(validationError: Eureka.ValidationError = Eureka.ValidationError(msg: "Field validation fails.."), id: String? = nil, closureGetList: @escaping (() -> [Any] )) {
        self.validationError = validationError
        self.closureGetList = closureGetList
        self.id = id
    }
}


public struct RuleNotNull: RuleType {
    public typealias RowValueType = String
    

    public var id: String?
    public var validationError: Eureka.ValidationError

     public var closureGetItem: () -> Any?

    public func isValid(value: String?) -> Eureka.ValidationError? {
        let item = closureGetItem()
        return item == nil ? validationError :  nil
    }

    public init(validationError: Eureka.ValidationError = Eureka.ValidationError(msg: "Field validation fails.."), id: String? = nil, closureGetItem: @escaping (() -> Any? )) {
        self.validationError = validationError
        self.closureGetItem = closureGetItem
        self.id = id
    }
}


