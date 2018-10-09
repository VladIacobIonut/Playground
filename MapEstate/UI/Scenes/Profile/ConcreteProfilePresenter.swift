//
//  ConcreteProfilePresenter.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

final class ConcreteProfilePresenter: ProfilePresenter {
    // MARK: - Properties
    
    weak var view: ProfileViewProtocol?
    private var viewModel: ProfileViewModel
    private var examples: [Example] = Example.allCases
    private var router: RootRouter
    // MARK: - Init
    
    init(viewModel: ProfileViewModel, router: RootRouter) {
        self.viewModel = viewModel
        self.router = router
    }
    
    func retrieveExamples() {
        viewModel.format(example: examples)
        view?.didProvidedExamples()
    }
    
    func presentExample(at index: Int) {
        router.presentExampleViewController(for: examples[index])
    }
}
