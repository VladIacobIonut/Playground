//
//  MapManager.swift
//  MapEstate
//
//  Created by Vlad on 17/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import Mapbox
import RealmSwift
import Realm

final class MapManager: GetMaptilesUC, GetDetailsUC, SetDetailsUC {
    // MARK: - Properties
    
    var currentProperty: Property?
    var persistanceManager: PersistanceManager
    
    // MARK: - Init
    
    init(persistanceManager: PersistanceManager) {
        self.persistanceManager = persistanceManager
    }
    
    // MARK: - Functions
    
    func loadMapTiles(completion: @escaping GetMaptilesUCO.Response) {
        DispatchQueue.global(qos: .background).async {
            let jsonPath = Bundle.main.path(forResource: "rectangles", ofType: "geojson")
            guard let path = jsonPath else {
                return
            }
            let url = URL(fileURLWithPath: path)
            
            do {
                var properties = [Property]()
                let data = try Data(contentsOf: url)
                let shapeCollectionFeature = try MGLShape(data: data, encoding: String.Encoding.utf8.rawValue) as! MGLShapeCollectionFeature
                if let polygons = shapeCollectionFeature.shapes as? [MGLPolygonFeature] {
                    polygons.forEach{ properties.append(Property(attributes: $0.attributes, polygon: $0)!) }
                    DispatchQueue.main.async {
                        completion(properties, nil)
                    }
                }
            }
            catch {
                completion(nil, "Parsing failed")
            }
        }
    }
    
    func setCurrentProperty(property: Property) {
        currentProperty = property
    }
    
    func updateCurrentProperty(shouldPersist: Bool) {
        guard let currentProperty = currentProperty else {
            return
        }
        persistanceManager.performOperation(of: shouldPersist ? .insert : .delete , [currentProperty]) { (status) in
            
        }
    }
}

