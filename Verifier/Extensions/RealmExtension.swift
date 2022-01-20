//
//  RealmExtension.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 11/07/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import RealmSwift


protocol DetachableObject: AnyObject {
    func detached() -> Self
}

protocol FillableFields: AnyObject {
    var fillable: [String] { get set }
}

extension FillableFields where Self: BaseRealm {
    func setAllFields(object: Object ) {
        for currentKey in fillable {
            self.setValue(object.value(forKey: currentKey), forKeyPath: currentKey)
        }
        
    }
}


extension Object: DetachableObject {
    
    func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            
            if property.isArray == true {
                //Realm List property support
                let detachable = value as? DetachableObject
                detached.setValue(detachable?.detached(), forKey: property.name)
            } else if property.type == .object {
                //Realm Object property support
                let detachable = value as? DetachableObject
                detached.setValue(detachable?.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

extension List: DetachableObject {
    func detached() -> List<Element> {
        let result = List<Element>()
        
        forEach {
            if let detachable = $0 as? DetachableObject {
                let detached = detachable.detached() as! Element
                result.append(detached)
            } else {
                result.append($0) //Primtives are pass by value; don't need to recreate
            }
        }
        
        return result
    }
    
    func toArray() -> [Element] {
        return Array(self.detached())
    }
}

extension Results {
    func toArray() -> [Element] {
        let result = List<Element>()
        
        forEach {
            result.append($0)
        }
        
        return Array(result.detached())
    }
}
