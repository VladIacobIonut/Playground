//
//  PropertiesManager.swift
//  MapEstate
//
//  Created by Vlad on 25/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

final class PropertiesManager: SetDetailsUC {
    // MARK: - Properties
    private var persistanceManager: PersistanceManager
    
    init(persistanceManager: PersistanceManager) {
        self.persistanceManager = persistanceManager
    }
    
    // MARK: - Functions
    func updateCurrentProperty(shouldPersist: Bool) {
        
    }
}
