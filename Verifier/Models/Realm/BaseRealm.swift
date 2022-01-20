//
//  Game.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 09/07/2019.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import UIKit
import RealmSwift

class BaseRealm: Object {

    @Persisted var id = UUID().uuidString
    
    @Persisted var isDeleted = false
    @Persisted var cretedAt = Date()


    override static func primaryKey( ) -> String? {
        return "id"
    }
    
    
    override required init() {

    }



}


extension Results where Element: BaseRealm {
    
    func notDeleted() -> Results<Element> {
        return self.filter("isDeleted = false")
    }
    
    func deleted() -> Results<Element> {
        return self.filter("isDeleted = true")
    }
    
}
