//
//  BasicSpringlyCollectionViewCell.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class BasicSpringlyCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    var shouldDismiss: VoidClosure?
    let label = UILabel()
    private var initialOffset: CGPoint = .zero
    private var fieldAnimator = UIDynamicAnimator()
    private var fieldBehaviour = UIFieldBehavior.springField()
    private let initialOrigin = CGPoint(x: 0, y: 0)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupSpringField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 15
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.randomColor()
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        label.font = UIFont.ceraPro(size: 34)
        label.textColor = UIColor.white
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        contentView.addGestureRecognizer(panGesture)
    }
    
    private func setupSpringField() {
        fieldAnimator = UIDynamicAnimator(referenceView: self)
        fieldBehaviour.addItem(contentView)
        fieldBehaviour.position = self.center
        fieldBehaviour.region = UIRegion(size: UIScreen.main.bounds.size)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [contentView])
        itemBehaviour.density = 0.6
        itemBehaviour.friction = 1
        
        fieldAnimator.addBehavior(itemBehaviour)
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: self)
        switch recognizer.state {
        case .began:
            fieldAnimator.removeAllBehaviors()
            initialOffset = CGPoint(x: touchPoint.x - contentView.center.x, y: touchPoint.y - contentView.center.y)
        case .changed:
            contentView.center = CGPoint(x: touchPoint.x - initialOffset.x, y: touchPoint.y - initialOffset.y)
        case .ended:
            let snapBehaviour = UISnapBehavior(item: contentView, snapTo: CGPoint(x: self.center.x - 10, y: self.center.y))
            snapBehaviour.damping = 0.2
            fieldAnimator.addBehavior(snapBehaviour)
            handleSwipeEnding(for: recognizer.velocity(in: self).x)
        default:
            break
        }
    }
    
    private func handleSwipeEnding(for xVelocity: CGFloat) {
        let velocity = abs(xVelocity)
        guard velocity > 500 else {
            return
        }
        
        fieldAnimator.removeAllBehaviors()
        contentView.transform = CGAffineTransform(translationX: xVelocity, y: 0)
        shouldDismiss?()
    }
}
