//
//  ConcreteDetailsPresenter.swift
//  MapEstate
//
//  Created by Vlad on 18/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

final class ConcreteDetailsPresenter: DetailsPresenter {
    // MARK: - Properties
    
    weak var view: DetailsViewProtocol?
    private let detailsUC: GetDetailsUC
    private let setDetailsUC: SetDetailsUC
    private var currentProperty: Property?
    // MARK: - Init
    
    init(detailsUC: GetDetailsUC, persistanceUC: SetDetailsUC) {
        self.detailsUC = detailsUC
        self.setDetailsUC = persistanceUC
    }
    
    // MARK: - Functions
    func persistDetails(for state: Bool) {
        setDetailsUC.updateCurrentProperty(shouldPersist: state)
    }
    
    func retrieveDetailsForCurrentProperty() {
        guard let property = detailsUC.currentProperty else {
            return
        }
        currentProperty = property
        view?.didRecieveDetails(for: property)
    }
}
