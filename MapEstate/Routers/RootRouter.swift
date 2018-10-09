//
//  RootRouter.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class RootRouter: Routable {
    // MARK: - Properties
    
    var appCore: AppCore
    var previous: Routable?
    var next: Routable?
    let window: UIWindow
    private let tabVC = CustomTabBarController()
    private var navVC = CustomNavigationController()
    
    // MARK: - Init
    
    init(window: UIWindow, appCore: AppCore) {
        self.window = window
        self.appCore = appCore
    }
    
    // MARK: - Functions
    
    func enter() {
        let viewModel = MapVM()
        let presenter = ConcreteMapPresenter(dependencies: ConcreteMapPDP(viewModel: viewModel, getMapTilesUC: appCore.getMapTilesUC), router: self)
        let mapVC = MapViewController(presenter: presenter, viewModel: viewModel)
        let profileViewModel = ProfileViewModel()
        let profilePresenter = ConcreteProfilePresenter(viewModel: profileViewModel, router: self)
        let profileVC = ProfileViewController(viewModel: profileViewModel, presenter: profilePresenter)
        
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "map"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Examples", image: #imageLiteral(resourceName: "profile"), tag: 1)
        navVC = CustomNavigationController(rootViewController: profileVC)
        tabVC.viewControllers = [mapVC, navVC]
        window.rootViewController = tabVC
    }
    
    func presentDetails(for property: Property, from frame: CGRect) {
        let detailsVC = DetailsViewController(presenter: ConcreteDetailsPresenter(detailsUC: appCore.getDetailsUC, persistanceUC: appCore.setDetailsUC))
        detailsVC.dismissTapped = {
            self.tabVC.animateHidden = false
            detailsVC.remove()
        }
        tabVC.viewControllers?.first?.add(detailsVC)
        tabVC.animateHidden = true
    }
    
    func presentExampleViewController(for example: Example) {
        navVC.pushViewController(example.viewController, animated: true)
    }
}
