//
//  CustomNavigationController.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    // MARK: - ViewControllers
    
    override func viewDidLoad() {
         super.viewDidLoad()

        navigationBar.prefersLargeTitles = true
        navigationBar.barStyle = .black
        navigationBar.tintColor = UIColor.white
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.ceraPro(size: 34)]
    }
}
