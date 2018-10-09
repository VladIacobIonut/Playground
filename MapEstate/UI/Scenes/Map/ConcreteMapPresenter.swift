//
//  ConcreteMapPresenter.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import Mapbox

final class ConcreteMapPresenter: MapPresenter {
    // MARK: - Properties
    
    weak var view: MapViewProtocol?
    var currentProperty: Property?
    private let viewModel: MapVM
    private let getMapTilesUC: GetMaptilesUC
    private var properties = [Property]()
    private let router: RootRouter
    
    init(dependencies: MapPDP, router: RootRouter) {
        self.viewModel = dependencies.viewModel
        self.getMapTilesUC = dependencies.getMapTilesUC
        self.router = router
    }
    
    // MARK: - Functions
    
    func retrieveMappedRectangles() {
        getMapTilesUC.loadMapTiles { (properties, error) in
            guard let properties = properties else {
                return
            }
            self.properties = properties
            self.viewModel.format(properties: properties)
            self.view?.didRecieveCoordinates()
        }
    }
    
    func presentReport(for tappedArea: MGLPolygonFeature, from frame: CGRect) {
        let property = properties.filter{ $0.polygon.isEqual(tappedArea) }
        guard let tappedProperty = property.first else {
            return
        }
        getMapTilesUC.setCurrentProperty(property: tappedProperty)
        router.presentDetails(for: tappedProperty, from: frame)
    }
}
