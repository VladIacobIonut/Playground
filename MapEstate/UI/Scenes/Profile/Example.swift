//
//  Example.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

enum Example: String, CaseIterable {
    case tinder = "Tinder Dashboard"
    case facetime = "Facetime PiP"
    case music = "AppleMusic Filter"
    case collectionView = "Shazam Discover"
    case fieldBehaviour = "UIKit Dynamics"
    case dottedLines = "Items Bar"
    
    var viewController: UIViewController {
        switch self {
        case .tinder:
            return TinderExampleViewController()
        case .facetime:
            return PipExampleViewController()
        case .music:
            return AppleMusicFilterViewController()
        case .collectionView:
            return CustomLayoutViewController()
        case .fieldBehaviour:
            return AttachmentBehaviorExampleViewController()
        case .dottedLines:
            return ItemsBarViewController()
        }
    }
    
    var image: UIImage {
        switch self {
        case .tinder:
            return #imageLiteral(resourceName: "tinder.png")
        case .facetime:
            return #imageLiteral(resourceName: "facetime.png")
        case .music:
            return #imageLiteral(resourceName: "music.png")
        case .collectionView:
            return #imageLiteral(resourceName: "shazam.png")
        case .fieldBehaviour:
            return #imageLiteral(resourceName: "physics.png")
        case .dottedLines:
            return #imageLiteral(resourceName: "flower.png")
        }
    }
}
