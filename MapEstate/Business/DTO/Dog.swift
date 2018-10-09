//
//  Dog.swift
//  MapEstate
//
//  Created by Vlad on 21/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import RealmSwift

struct Dog {
    // MARK : - Properties
    var name: String
    var age: Int
    var id: Int
    
    // MARK: - Init
    
    init(id: Int, name: String = "Dog_name", age: Int = 0) {
        self.name = name
        self.age = age
        self.id = id
    }
}

class RealmPersistableDog: Object {
    // MARK: - Properties
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    
    // MARK: - Override
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - PersistableModel

extension Dog: PersistableModel {
    //MARK: - Properties
    var uniqueIdentifier: Int {
        return id
    }
    
    var persistable: RealmPersistableDog {
        let dog = RealmPersistableDog()
        dog.name = name
        dog.age = age
        dog.id = id
        
        return dog
    }
    
    // MARK: - Init
    
    init(object: RealmPersistableDog) {
        self.name = object.name
        self.age = object.age
        self.id = object.id
    }
}
