//
//  PersistableModel.swift
//  MapEstate
//
//  Created by Vlad on 21/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import RealmSwift

protocol PersistableModel: UniqueIdentifiable {
    associatedtype RealmClass: Object
    
    var persistable: RealmClass { get }
    init(object: Self.RealmClass)
}
