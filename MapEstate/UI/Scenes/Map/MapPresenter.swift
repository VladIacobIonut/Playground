//
//  MapPresenter.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import Mapbox

protocol MapPresenter {
    var currentProperty: Property? { get }
    var view: MapViewProtocol? { get set }
    func retrieveMappedRectangles()
    func presentReport(for tappedArea: MGLPolygonFeature, from frame: CGRect)
}
