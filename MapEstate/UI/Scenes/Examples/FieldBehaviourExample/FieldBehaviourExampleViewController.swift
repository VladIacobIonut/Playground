//
//  FieldBehaviourExampleViewController.swift
//  MapEstate
//
//  Created by Vlad on 11/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class FieldBehaviourExampleViewController: UIViewController {
    // MARK: - Properties
    
    private let dynamicView = UIView()
    private lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.view)
    }()
    
    private var initialOffset = CGPoint.zero
    private let height = 100
    private let spring = UIFieldBehavior.springField()
    private var itemBehavior = UIDynamicItemBehavior(items: [])
    private lazy var viewCenter: CGPoint = {
       return CGPoint(x: view.center.x - CGFloat(height / 2),
                      y: view.center.y - CGFloat(height / 2))
    }()
    private var springBehaviour: SpringFieldBehavior!
    
    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.blueishBlack
        setupUI()
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        view.addSubview(dynamicView)
        dynamicView.backgroundColor = UIColor.applePurple
        dynamicView.layer.cornerRadius = 15
        dynamicView.frame = CGRect(origin: viewCenter, size: CGSize(width: height, height: height))
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        dynamicView.addGestureRecognizer(panGesture)
        
        springBehaviour = SpringFieldBehavior(item: dynamicView)
        animator.addBehavior(springBehaviour)
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        let touchPoint: CGPoint = recognizer.location(in: self.view)
        
        switch recognizer.state {
        case .began:
            initialOffset.x = touchPoint.x - dynamicView.center.x
            initialOffset.y = touchPoint.y - dynamicView.center.y
            springBehaviour.isEnabled = false
        case .changed:
            dynamicView.center = CGPoint(x: dynamicView.center.x , y: touchPoint.y - initialOffset.y)
            break
        case .ended:
            springBehaviour.isEnabled = true
            springBehaviour.addLinearVelocity(recognizer.velocity(in: view))
        default:
            ()
        }
    }
}
