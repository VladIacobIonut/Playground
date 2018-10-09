//
//  CustomTabBarController.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    // MARK: - ViewController
    
    var animateHidden: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.tabBar.transform = self.animateHidden ? CGAffineTransform(translationX: 0, y: 50) : CGAffineTransform.identity
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barStyle = .black
        tabBar.tintColor = UIColor.seaGreen
    }
}


