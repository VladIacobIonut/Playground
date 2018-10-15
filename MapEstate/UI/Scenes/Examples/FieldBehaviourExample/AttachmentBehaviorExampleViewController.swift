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
        return UIDynamicAnimator(referenceView: view)
    }()
    
    private var offset = CGPoint.zero
    private let height = 400
    private lazy var width: Int = {
       return Int(view.bounds.width)
    }()
    private var attachmentBehavior: AttachmentBehavior!
    
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
        dynamicView.frame = CGRect(x: 160, y: 160, width: width, height: height)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        dynamicView.addGestureRecognizer(panGesture)
        
        attachmentBehavior = AttachmentBehavior(item: dynamicView, anchorPoint: CGPoint(x: view.frame.width / 2, y: view.frame.height / 2))
        animator.addBehavior(attachmentBehavior)
    }
    
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        var location: CGPoint = recognizer.location(in: view)
        switch recognizer.state {
        case .began:
            offset.x = location.x - dynamicView.center.x
            offset.y = location.y - dynamicView.center.y
            
            attachmentBehavior.isEnabled = false
        case .changed:
            // Get reference bounds.
            let referenceBounds = view.bounds
            let referenceWidth = referenceBounds.width
            let referenceHeight = referenceBounds.height
            
            // Get item bounds.
            let itemBounds = dynamicView.bounds
            let itemHalfWidth = itemBounds.width / 2.0
            let itemHalfHeight = itemBounds.height / 2.0
            
            // Apply the initial offset.
            location.x -= offset.x
            location.y -= offset.y
            
            // Bound the item position inside the reference view.
            location.x = max(itemHalfWidth, location.x)
            location.x = min(referenceWidth - itemHalfWidth, location.x)
            location.y = max(itemHalfHeight, location.y)
            location.y = min(referenceHeight - itemHalfHeight, location.y)
            
            dynamicView.center = location
        case .ended, .cancelled:
            attachmentBehavior.gravityDirection = dynamicView.center.y > view.center.y ? 1 : -1
            attachmentBehavior.isEnabled = true
        default: ()
        }
    }
}
