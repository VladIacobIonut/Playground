//
//  BubblesBehavior.swift
//  MapEstate
//
//  Created by Vlad on 15/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class BubblesBehavior: UIDynamicBehavior {
    // MARK: - Properties
        
    var radialGravityPosition: CGPoint = .zero {
        didSet {
            guard gravityField != nil else { return }
            gravityField.position = radialGravityPosition
        }
    }
    
    var density: CGFloat = 1 {
        didSet {
            itemsBehavior.density = density
        }
    }
    
    var gravityStrength: CGFloat = 7 {
        didSet {
            guard gravityField != nil else { return }
            gravityField.strength = gravityStrength
        }
    }
    
    private var collisionBehavior: UICollisionBehavior
    private var itemsBehavior: UIDynamicItemBehavior
    private var items: [UIDynamicItem]
    private var gravityField: UIFieldBehavior!
    
    // MARK: - Init
    
    init(items: [UIDynamicItem]) {
        self.items = items
        self.collisionBehavior = UICollisionBehavior(items: items)
        self.itemsBehavior = UIDynamicItemBehavior(items: items)
        
        super.init()
        
        setupBehaviors()
    }
    
    // MARK: - DynamicAnimator
    
    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
        super.willMove(to: dynamicAnimator)
        
        guard let refView = dynamicAnimator?.referenceView else { return }
        radialGravityPosition = refView.center
        
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 80, left: 0, bottom: 50, right: 0))
        collisionBehavior.collisionMode = .everything

        gravityField = UIFieldBehavior.radialGravityField(position: refView.center)
        gravityField.region = UIRegion(radius: refView.bounds.height * 5)
        gravityField.strength = 6
        gravityField.animationSpeed = 1
        gravityField.falloff = 0.1
        
        items.forEach { gravityField.addItem($0) }

        addChildBehavior(gravityField)
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemsBehavior)
    }
    
    // MARK: - Functions
    
    private func setupBehaviors() {
        itemsBehavior.density = 1
        itemsBehavior.elasticity = 0
        itemsBehavior.friction = 10
        itemsBehavior.resistance = 2
        itemsBehavior.allowsRotation = false
    }
}
