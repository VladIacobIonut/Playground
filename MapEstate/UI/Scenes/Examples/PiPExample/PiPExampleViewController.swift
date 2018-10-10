//
//  PiPExample.swift
//  MapEstate
//
//  Created by Vlad on 04/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class PipExampleViewController: UIViewController {
    // MARK: - Properties
    private let topLeftView = UIView()
    private let topRightView = UIView()
    private let bottomLeftView = UIView()
    private let bottomRightView = UIView()
    private let cornerViewsWidth: CGFloat = 80
    private let cornerViewHeight: CGFloat = 120
    private let pictureView = UIView()
    private lazy var cornerView: [UIView] = [topLeftView, topRightView, bottomLeftView, bottomRightView]
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blueishBlack
        navigationItem.largeTitleDisplayMode = .never
        setupCornerView()
        setupDraggableImageView()
    }
    
    // MARK: - Private Functions
    
    private func setupCornerView() {
        _ = cornerView.map {
            view.addSubview($0)
            $0.backgroundColor = .clear
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.cornerRadius = 10
        }
        
        topLeftView.frame = CGRect(x: view.frame.minX + 20, y: view.frame.minY + 80, width: cornerViewsWidth, height: cornerViewHeight)
        topRightView.frame = CGRect(x: view.frame.maxX - cornerViewsWidth - 20, y: view.frame.minY + 80, width: cornerViewsWidth, height: cornerViewHeight)
        bottomLeftView.frame = CGRect(x: view.frame.minX + 20, y: view.frame.maxY - cornerViewHeight - 55, width: cornerViewsWidth, height: cornerViewHeight)
        bottomRightView.frame = CGRect(x: view.frame.maxX  - cornerViewsWidth - 20, y: view.frame.maxY - cornerViewHeight - 55, width: cornerViewsWidth, height: cornerViewHeight)
    }
    
    private func setupDraggableImageView() {
        pictureView.backgroundColor = UIColor.seaGreen
        view.addSubview(pictureView)
        pictureView.frame = topLeftView.frame
        pictureView.layer.cornerRadius = 10
        
        let itemBehaviour = UIDynamicItemBehavior(items: [pictureView])
        itemBehaviour.resistance = 10
        itemBehaviour.elasticity = 0.2
        itemBehaviour.density = 0.1
        itemBehaviour.friction = 0
        
        animator.addBehavior(itemBehaviour)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePictureViewPan(recognizer:)))
        pictureView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePictureViewPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.removeAllBehaviors()
        case .changed:
            let translation = recognizer.translation(in: pictureView)
            pictureView.center = CGPoint(x: pictureView.center.x + translation.x , y: pictureView.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
        case .ended:
            let decelerationRate = UIScrollView.DecelerationRate.normal.rawValue
            let velocity = recognizer.velocity(in: view)
            let projectedPosition = CGPoint(
                x: pictureView.center.x + project(initialVelocity: velocity.x, decelerationRate: decelerationRate),
                y: pictureView.center.y + project(initialVelocity: velocity.y, decelerationRate: decelerationRate))
            
            let snappingBehaviour = UISnapBehavior(item: pictureView, snapTo: nearestCorner(to: projectedPosition))
            snappingBehaviour.damping = 1
            animator.addBehavior(snappingBehaviour)
        default:
            break
        }
    }
    
    /// Distance travelled after decelarting to zero velocity at a constant rate.
    private func project(initialVelocity: CGFloat, decelerationRate: CGFloat) -> CGFloat {
        return (initialVelocity / 1000) * decelerationRate / (1 - decelerationRate)
    }
    
    private func nearestCorner(to point: CGPoint) -> CGPoint {
        var minDistance = CGFloat.greatestFiniteMagnitude
        var closestPosition = CGPoint.zero
        let centerPoints = cornerView.map { $0.center }
        for position in centerPoints {
            let distance = point.distance(to: position)
            if distance < minDistance {
                closestPosition = position
                minDistance = distance
            }
        }
        return closestPosition
    }
}
