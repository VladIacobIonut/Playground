//
//  AppCore.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class AppCore {
    // MARK: - Properties
    
    let window: UIWindow
    
    var getMapTilesUC: GetMaptilesUC {
        return mapManager
    }
    
    var getDetailsUC: GetDetailsUC {
        return mapManager
    }
    
    var setDetailsUC: SetDetailsUC {
        return mapManager
    }
    
    // MARK: - Managers
    private let mapManager: MapManager
    private let persistanceManager: PersistanceManager
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        
        self.persistanceManager = PersistanceManager()
        self.mapManager = MapManager(persistanceManager: persistanceManager)
        setupRouter()
    }
    
    // MARK: - Private Functions
    
    private func setupRouter() {
        let rootRouter = RootRouter(window: window, appCore: self)
        rootRouter.enter()
    }
}
