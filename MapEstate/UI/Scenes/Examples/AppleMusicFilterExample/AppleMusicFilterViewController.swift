//
//  AppleMusicFilterViewController.swift
//  MapEstate
//
//  Created by Vlad on 04/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class AppleMusicFilterViewController: UIViewController {
    // MARK: - Properties
    private let bubbleViewHeight: CGFloat = 100
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    private var pushBehaviour = UIPushBehavior()
    private var bubbleView = BubbleView(type: "Rock")
    private var bubbleView1 = BubbleView(type: "Alternative")
    private var bubbleView2 = BubbleView(type: "Classic")
    private lazy var bubbleViews: [UIView] = [bubbleView, bubbleView1, bubbleView2]
    
    // MARK: - ViewControlller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blueishBlack
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        bubbleViews.map {
            view.addSubview($0)
            $0.backgroundColor = UIColor.appleMusicRed
            $0.layer.cornerRadius = bubbleViewHeight / 2
        }
        
        bubbleView.frame = CGRect(x: view.center.x - bubbleViewHeight / 2, y: view.center.y - bubbleViewHeight / 2, width: bubbleViewHeight, height: bubbleViewHeight)
        bubbleView2.frame = CGRect(x: view.center.x + bubbleViewHeight / 2, y: view.center.y + bubbleViewHeight / 2,width: bubbleViewHeight, height: bubbleViewHeight)
        bubbleView1.frame = CGRect(x: view.center.x - bubbleViewHeight / 2, y: view.center.y + bubbleViewHeight / 2,width: bubbleViewHeight, height: bubbleViewHeight)
        
        let collisionBehaviour = UICollisionBehavior(items: bubbleViews)
        collisionBehaviour.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 80, left: 1, bottom: 50, right: 1))
        collisionBehaviour.collisionMode = .everything
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = true
        
        let ballDynamicsProperties = UIDynamicItemBehavior(items: bubbleViews)
        ballDynamicsProperties.elasticity = 0.5
        ballDynamicsProperties.friction = 0
        ballDynamicsProperties.resistance = 0
        
        pushBehaviour = UIPushBehavior(items: bubbleViews, mode: UIPushBehavior.Mode.continuous)
        pushBehaviour.pushDirection = CGVector(dx: -5, dy: 6)
    
        animator.addBehavior(ballDynamicsProperties)
        animator.addBehavior(pushBehaviour)
        animator.addBehavior(collisionBehaviour)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePictureViewPan(recognizer:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePictureViewPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.removeBehavior(pushBehaviour)
        case .changed:
            let translation = recognizer.translation(in: view)
            pushBehaviour.pushDirection = CGVector(dx: translation.x, dy: translation.y)
            animator.addBehavior(pushBehaviour)
        case .ended:
            animator.removeBehavior(pushBehaviour)
        default:
            break
        }
    }
}
