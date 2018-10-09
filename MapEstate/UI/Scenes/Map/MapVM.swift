//
//  MapVM.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import Mapbox

final class MapVM {
    var polygons = [MGLPolygonFeature]()
    
    // MARK: - Functions
    
    func format(properties: [Property]) {
        properties.forEach{ polygons.append($0.polygon) }
    }
}
