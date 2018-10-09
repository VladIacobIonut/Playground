//
//  UIButton+Extensions.swift
//  MapEstate
//
//  Created by Vlad on 14/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

extension UIButton {
    func apply(style: ButtonStyles) {
        self.backgroundColor = style.color
        self.setTitleColor(UIColor.white, for: .normal)
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.ceraPro(size: 17)
    }
}

enum ButtonStyles {
    case seaGreenButton
    case dismissButton
    
    var color: UIColor {
        switch self {
        case .seaGreenButton:
            return UIColor.seaGreen
        case .dismissButton:
            return UIColor.blueishBlack
        }
    }
}
