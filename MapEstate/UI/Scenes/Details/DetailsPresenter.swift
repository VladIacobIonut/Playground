//
//  DetailsPresenter.swift
//  MapEstate
//
//  Created by Vlad on 18/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

protocol DetailsPresenter: class {
    var view: DetailsViewProtocol? { get set }
    func persistDetails(for state: Bool)
    func retrieveDetailsForCurrentProperty()
}
