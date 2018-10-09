//
//  RealmModel.swift
//  MapEstate
//
//  Created by Vlad on 24/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

protocol RealmModel {
    func configure<T>(with object: T) where T: PersistableModel
}
