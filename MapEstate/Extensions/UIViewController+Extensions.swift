//
//  UIViewController+Extensions.swift
//  MapEstate
//
//  Created by Vlad on 14/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Functions
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func addSubview(view: UIView) {
        view.addSubview(view)
    }
}
