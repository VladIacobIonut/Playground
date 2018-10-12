//
//  AttachmentBehaviorExampleViewController.swift
//  MapEstate
//
//  Created by Vlad on 12/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class AttachmentBehaviorExampleViewController: UIViewController {
    // MARK: - Properties
    
    private let dynamicView = UIView()
    private lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.view)
    }()
    
    private var initialOffset = CGPoint.zero
    private let height = 100
    private lazy var width: Int = {
       return 150
    }()
    private var attachmentBehavior: SpringFieldBehavior!
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.blueishBlack
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.addSubview(dynamicView)
        dynamicView.backgroundColor = UIColor.applePurple
        dynamicView.layer.cornerRadius = 20
        dynamicView.frame = CGRect(x: 0, y: 160, width: width, height: height)
        
        let panGesture = InstantPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        dynamicView.addGestureRecognizer(panGesture)
        
//        attachmentBehavior = AttachmentBehavior(item: dynamicView, anchorPoint: CGPoint(x: view.frame.width / 2, y: view.frame.height))
        attachmentBehavior = SpringFieldBehavior(item: dynamicView)
        animator.addBehavior(attachmentBehavior)
    }
    
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        let touchPoint: CGPoint = recognizer.location(in: self.view)
        
        switch recognizer.state {
        case .began:
            attachmentBehavior.isEnabled = false
            initialOffset.x = touchPoint.x - dynamicView.center.x
            initialOffset.y = touchPoint.y - dynamicView.center.y
        case .changed:
            dynamicView.center = CGPoint(x: touchPoint.x - initialOffset.x, y: touchPoint.y - initialOffset.y)
        case .ended:
//            attachmentBehavior.addLinearVelocity(velocity: recognizer.velocity(in: view))
            attachmentBehavior.isEnabled = true
        default:
            ()
        }
    }
}
