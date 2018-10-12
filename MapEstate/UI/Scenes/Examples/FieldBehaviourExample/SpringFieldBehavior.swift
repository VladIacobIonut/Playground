//
//  SpringFieldBehavior.swift
//  MapEstate
//
//  Created by Vlad on 11/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class SpringFieldBehavior: UIDynamicBehavior {
    // MARK: - Properties
    
    private var item: UIDynamicItem
    private var collisionBehavior: UICollisionBehavior
    private var magneticField = UIFieldBehavior.magneticField()
    private var springField = UIFieldBehavior.springField()
    private var itemBehavior: UIDynamicItemBehavior
    
    // Enabling/disabling effectively removes the item from the child behaviors
    var isEnabled = true {
        didSet {
            if isEnabled {
//                springField.addItem(item)
                magneticField.addItem(item)
                collisionBehavior.addItem(item)
                itemBehavior.addItem(item)
            }
            else {
//                springField.removeItem(item)
                magneticField.removeItem(item)
                collisionBehavior.removeItem(item)
                itemBehavior.removeItem(item)
            }
        }
    }
    // MARK: - Init
    
    init(item: UIDynamicItem) {
        self.item = item
        self.collisionBehavior = UICollisionBehavior(items: [item])
        self.itemBehavior = UIDynamicItemBehavior(items: [item])
        
        super.init()
        
        setupItemBehavior()
        springField.addItem(item)
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
//        addChildBehavior(springField)
        addChildBehavior(magneticField)
    }
    
    // MARK: - UIDynamicBehavior
    
    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
        super.willMove(to: dynamicAnimator)
        
        guard let bounds = dynamicAnimator?.referenceView?.bounds else { return }
        
        updateSpringField(for: bounds)
    }
    
    // MARK: - Functions
    
    func addLinearVelocity(_ velocity: CGPoint) {
        itemBehavior.addLinearVelocity(velocity, for: item)
    }
    
    // MARK: - Private Functions
    
    private func updateSpringField(for bounds: CGRect) {
        springField.region = UIRegion(size: CGSize(width: bounds.size.width * 40, height: bounds.size.height * 40))
        springField.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        magneticField.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        magneticField.region = UIRegion(size: CGSize(width: bounds.size.width, height: bounds.size.height))
        
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func setupItemBehavior() {
        itemBehavior.density = 0.01
        itemBehavior.resistance = 10
        itemBehavior.friction = 0.0
//        itemBehavior.allowsRotation = false
    }
}
