//
//  HorizontalDottedLine.swift
//  HeatNL
//
//  Created by Laurentiu Ungur on 19/04/2018.
//  Copyright © 2018 P3 Digital Services. All rights reserved.
//

import UIKit

final class HorizontalDottedLine: UIView {
    // MARK: - Properties
    
    var dotColor = UIColor.oceanBlue
    
    // MARK: - Base Class Overrides
    
    override func draw(_ rect: CGRect) {
        UIColor.oceanBlue.setFill()
        UIRectFill(rect)
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let path = UIBezierPath()
        
        let beginFromLeft = CGFloat(0.0)
        let left = CGPoint(x: beginFromLeft, y: height / 2)
        let right = CGPoint(x: width, y: height / 2)
        
        path.move(to: left)
        path.addLine(to: right)
        
        dotColor.setStroke()
        path.stroke()
    }
}
