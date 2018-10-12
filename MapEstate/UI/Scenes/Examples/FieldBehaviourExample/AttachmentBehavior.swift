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

    var isEnabled: Bool = true {
        didSet {
            if isEnabled {
                commonGravityField.addItem(item)
                inverseGravityField.addItem(item)
                addChildBehavior(inverseGravityField)
                addChildBehavior(commonGravityField)
            }
            else {
                commonGravityField.removeItem(item)
                inverseGravityField.removeItem(item)
                removeChildBehavior(inverseGravityField)
                removeChildBehavior(commonGravityField)
            }
        }
    }
    
    private var slidingAttachment: UIAttachmentBehavior!
    private var collisionBehavior: UICollisionBehavior
    private var item: UIDynamicItem
    private var inverseGravityField: UIFieldBehavior
    private var commonGravityField: UIFieldBehavior
    private var itemBehavior: UIDynamicItemBehavior
    
    // MARK: - Init
    
    init(item: UIDynamicItem, anchorPoint: CGPoint) {
        self.item = item
        self.collisionBehavior = UICollisionBehavior(items: [item])
        self.inverseGravityField = UIFieldBehavior.linearGravityField(direction: CGVector(dx: 0, dy: -1))
        self.commonGravityField = UIFieldBehavior.linearGravityField(direction: CGVector(dx: 0, dy: 1))
        self.itemBehavior = UIDynamicItemBehavior(items: [item])
        
        super.init()
        
        setupBehaviors()
    }
    
    // MARK: - Dynamic Animator
    
    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
        super.willMove(to: dynamicAnimator)
        
        guard let referenceView = dynamicAnimator?.referenceView?.frame else { return }
        inverseGravityField.position = CGPoint(x: referenceView.width / 2, y: 0)
        commonGravityField.position = CGPoint(x: referenceView.width / 2, y: referenceView.height)

        commonGravityField.region = UIRegion(size: CGSize(width: referenceView.width, height: referenceView.height))
        inverseGravityField.region = UIRegion(size: CGSize(width: referenceView.width, height: 2 * referenceView.height))

        inverseGravityField.strength = 50
        commonGravityField.strength = 50

//        addChildBehavior(commonGravityField)
        addChildBehavior(inverseGravityField)
        
        slidingAttachment = UIAttachmentBehavior.slidingAttachment(with: item, attachmentAnchor: CGPoint(x: referenceView.width / 2, y: 0), axisOfTranslation: CGVector(dx: 0, dy: -1))
        addChildBehavior(slidingAttachment)
    }
    
    // MARK: - Setup Behaviors
    
    private func setupBehaviors() {
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 80, left: 0, bottom: -400, right: 0))
        
        // Set properties for the animated dynamic object
        
        itemBehavior.density = 0.01
        itemBehavior.resistance = 10
        itemBehavior.friction = 0.0
        itemBehavior.allowsRotation = false
        
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    // MARK: - Functions
    
    func addLinearVelocity(velocity: CGPoint) {
        itemBehavior.addLinearVelocity(velocity, for: item)
    }
}
