//
//  Routable.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

protocol Routable {
    var appCore: AppCore { get set }
    var previous: Routable? { get set }
    var next: Routable? { get set }
    
    func enter()
}
