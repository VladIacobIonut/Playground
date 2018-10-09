//
//  TinderExampleViewController.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class TinderExampleViewController: UIViewController {
    // MARK: - Properties
    private let swipableView = UIView()
    private var snapping: UISnapBehavior!
    private var animator: UIDynamicAnimator!
    private var backgroundView = UIView()
    private var backgroundAnimator = UIViewPropertyAnimator()
    private var animationProgress: CGFloat = 0
    private var backgroundViewTransform = CGAffineTransform()
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        snapping = UISnapBehavior(item: swipableView, snapTo: view.center)
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.blueishBlack
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(swipableView)
    
        swipableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(400)
        }
        
        backgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(400)
        }
        
        backgroundView.layer.cornerRadius = 15
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundView.layer.shadowRadius = 20
        backgroundView.layer.shadowOpacity = 0.4
        backgroundView.alpha = 0.2
        
        backgroundViewTransform = CGAffineTransform(translationX: 0, y: 20)
//        backgroundView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        backgroundView.transform = backgroundViewTransform
        
        swipableView.layer.cornerRadius = 15
        swipableView.layer.shadowColor = UIColor.lightGray.cgColor
        swipableView.layer.shadowOpacity = 0.4
        swipableView.layer.shadowRadius = 20
        swipableView.backgroundColor = UIColor.seaGreen
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView(recognizer:)))
        swipableView.addGestureRecognizer(panGesture)
        swipableView.isUserInteractionEnabled = true
    }
    
    @objc private func pannedView(recognizer: UIPanGestureRecognizer) {
        
        // TODO: - Animate background view to screen as front view is panned away
        switch recognizer.state {
        case .began:
            animator.removeBehavior(snapping)
            setupAnimator()
            animationProgress = backgroundAnimator.fractionComplete
            print("begin")
        case .changed:
//            animationProgress = backgroundAnimator.fractionComplete
            let translation = recognizer.translation(in: swipableView)
            let fraction = translation.x / backgroundViewTransform.ty
            backgroundView.transform = CGAffineTransform(translationX: 0, y: fraction * 20)
            if fraction != 0 { print(fraction) }
            swipableView.center = CGPoint(x: swipableView.center.x + translation.x,
                                          y: swipableView.center.y + translation.y)
            
            backgroundAnimator.fractionComplete = animationProgress + abs(fraction)
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled:
            handleVelocity(value: recognizer.velocity(in: view).x)
            animator.addBehavior(snapping)
        default:
            break
        }
    }
    
    private func handleVelocity(value: CGFloat) {
        if value < -400 {

        }
        else if value > 400 {

        }
    }
    
    private func setupAnimator() {
        backgroundAnimator = UIViewPropertyAnimator(duration: 0, dampingRatio: 0.3, animations: {
            self.backgroundView.transform = CGAffineTransform.identity
        })
        backgroundAnimator.startAnimation()
        backgroundAnimator.pauseAnimation()
    }
}
