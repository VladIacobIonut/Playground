//
//  GetMaptilesUC.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

protocol GetMaptilesUC: class {
    func loadMapTiles(completion: @escaping GetMaptilesUCO.Response)
    func setCurrentProperty(property: Property)
}

protocol GetMaptilesUCO {
    typealias Response = ([Property]?, String?) -> Void
}
