//
//  Property.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import Mapbox
import Realm
import RealmSwift

typealias AttributesDictionary = [String : Any]

struct Property {
    // MARK: - Properties
    var id: Int
    var owner: String
    var polygon: MGLPolygonFeature
    
    // MARK: - Init
    
    init?(attributes: AttributesDictionary, polygon: MGLPolygonFeature) {
        
        guard let id = attributes["id"] as? Int,
              let owner = attributes["owner"] as? String else {
                return nil
        }
        
        self.id = id
        self.owner = owner
        self.polygon = polygon
    }
}

extension Property: PersistableModel {    
    var uniqueIdentifier: Int {
        return id
    }
    
    var persistable: RealmPersistableProperty {
        let persistableProperty = RealmPersistableProperty()
        persistableProperty.id = id
        persistableProperty.owner = owner
        
        return persistableProperty
    }

    init(object: RealmPersistableProperty) {
        self.id = object.id
        self.owner = object.owner
        self.polygon = MGLPolygonFeature()
    }
}

class RealmPersistableProperty: Object {
    // MARK: - Properties
    @objc dynamic var id = 0
    @objc dynamic var owner = "Owner"
    
    // MARK: - Override
    
    override static func primaryKey() -> String? {
        return "id"
    }
}



