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
    private var bubblesBehavior: BubblesBehavior!
    private var bubbleView = BubbleView(type: "Rock")
    private var bubbleView1 = BubbleView(type: "Alternative")
    private var bubbleView2 = BubbleView(type: "Classic")
    private lazy var bubbleViews: [UIView] = [bubbleView, bubbleView1, bubbleView2]
    private var offset: CGPoint = .zero
    
    // MARK: - ViewControlller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blueishBlack
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        _ = bubbleViews.map {
            view.addSubview($0)
            $0.backgroundColor = UIColor.appleMusicRed
            $0.layer.cornerRadius = bubbleViewHeight / 2
        }
        
        bubbleView.frame = CGRect(x: view.center.x - bubbleViewHeight / 2, y: view.center.y - bubbleViewHeight / 2, width: bubbleViewHeight, height: bubbleViewHeight)
        bubbleView2.frame = CGRect(x: view.center.x + bubbleViewHeight / 2, y: view.center.y + bubbleViewHeight / 2,width: bubbleViewHeight, height: bubbleViewHeight)
        bubbleView1.frame = CGRect(x: view.center.x - bubbleViewHeight / 2, y: view.center.y + bubbleViewHeight / 2,width: bubbleViewHeight, height: bubbleViewHeight)
        
        bubblesBehavior = BubblesBehavior(items: bubbleViews)
        animator.addBehavior(bubblesBehavior)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePictureViewPan(recognizer:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePictureViewPan(recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.translation(in: view)
        
        switch recognizer.state {
        case .began:
            offset.x = touchPoint.x - view.center.x
            offset.y = touchPoint.y - view.center.y
            bubblesBehavior.radialGravityPosition = touchPoint
            bubblesBehavior.gravityStrength = 20
            bubblesBehavior.density = 1
            
        case .changed:
            bubblesBehavior.radialGravityPosition = CGPoint(x: touchPoint.x - offset.x, y: touchPoint.y - offset.y)
            
        case .ended:
            bubblesBehavior.radialGravityPosition = view.center
            bubblesBehavior.gravityStrength = 1
            bubblesBehavior.density = 7
            
        default:
            break
        }
    }
}
