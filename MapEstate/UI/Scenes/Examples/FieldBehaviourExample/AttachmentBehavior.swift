//
//  AttachmentBehavior.swift
//  MapEstate
//
//  Created by Vlad on 12/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class AttachmentBehavior: UIDynamicBehavior {
    // MARK: - Properties

    var isEnabled = true {
        didSet {
            if isEnabled {
                collisionBehavior.addItem(item)
                commonGravityField.addItem(item)
                itemBehavior.addItem(item)
            }
            else {
                collisionBehavior.removeItem(item)
                commonGravityField.removeItem(item)
                itemBehavior.removeItem(item)
            }
        }
    }
    var gravityDirection = 1 {
        didSet {
            commonGravityField.gravityDirection = CGVector(dx: 0, dy: gravityDirection)
        }
    }
    
    private var collisionBehavior: UICollisionBehavior
    private var commonGravityField: UIGravityBehavior
    private var item: UIDynamicItem
    private var itemBehavior: UIDynamicItemBehavior
    
    // MARK: - Init
    
    init(item: UIDynamicItem, anchorPoint: CGPoint) {
        self.item = item
        self.collisionBehavior = UICollisionBehavior(items: [item])
        self.itemBehavior = UIDynamicItemBehavior(items: [item])
        self.commonGravityField = UIGravityBehavior(items: [item])
        
        super.init()
        
        setupBehaviors()
    }
    
    // MARK: - Dynamic Animator
    
    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
        super.willMove(to: dynamicAnimator)
        
        guard let referenceView = dynamicAnimator?.referenceView?.bounds else { return }
        
    }
    
    // MARK: - Setup Behaviors
    
    private func setupBehaviors() {
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 80, left: 0, bottom: -300, right: 0))
        
        addChildBehavior(commonGravityField)
        addChildBehavior(itemBehavior)
        addChildBehavior(collisionBehavior)
    }
    
    // MARK: - Functions
    
    func addLinearVelocity(velocity: CGPoint) {
        itemBehavior.addLinearVelocity(velocity, for: item)
    }
}
