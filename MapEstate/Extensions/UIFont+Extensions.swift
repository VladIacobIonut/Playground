//
//  UIFont+Extensions.swift
//  MapEstate
//
//  Created by Vlad on 14/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func ceraPro(size: CGFloat) -> UIFont {
        return UIFont(name: "Cera Pro", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
