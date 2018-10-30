//
//  UIColor+Extensions.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: - Properties
    
    private static var colorIndex: Int = 0
    
    static let seaGreen = UIColor(red: 122/255, green: 233/255, blue: 187/255, alpha: 1.0)
    static let blueishBlack = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
    static let darkJungleGreen = UIColor(red: 28/255, green: 25/255, blue: 33/255, alpha: 1.0)
    static let appleMusicRed = UIColor(red: 182/255, green: 49/255, blue: 88/255, alpha: 1.0)
    static let oceanBlue = UIColor(red: 0/255, green: 114/255, blue: 180/255, alpha: 1.0)
    
    // Apple Guideline Colors
    static let appleRed = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    static let appleOrange = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
    static let applePurple = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.0)
    static let appleGreen = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    static let appleColors: [UIColor] = [appleRed, appleOrange, applePurple, appleGreen]
    
    static func randomColor() -> UIColor {
        guard colorIndex < appleColors.count else {
            colorIndex = 0
            return appleOrange
        }
        let nextColor = appleColors[colorIndex]
        colorIndex += 1
        return nextColor
    }
}
