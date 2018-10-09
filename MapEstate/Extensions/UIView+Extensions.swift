//
//  UIView+Extensions.swift
//  MapEstate
//
//  Created by Vlad on 14/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Functions
    
    func addBlurEffect()
    {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        self.insertSubview(blur, at: 0)
    }
    
    func addShadow(opacity: Float, color: CGColor) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 25
    }
}
