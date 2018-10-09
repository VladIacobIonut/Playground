//
//  CGPoint+Extensions.swift
//  MapEstate
//
//  Created by Vlad on 04/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    
    /// Calculates the distance between two points in 2D space.
    /// + returns: The distance from this point to the given point.
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
}

