//
//  SearchView.swift
//  MapEstate
//
//  Created by Vlad on 02/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import UIKit

final class SearchView: UIView {
    // MARK: - Properties
    var closedTransform = CGAffineTransform.identity
    private let blurView = UIVisualEffectView()
    private var animator = UIViewPropertyAnimator()
    private var isOpen = false
    private var animationProgress: CGFloat = 0
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        clipsToBounds = true
        
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        let topLabel = UILabel()
        let middleLabel = UILabel()
        let bottomLabel = UILabel()
        topLabel.font = UIFont.ceraPro(size: 24)
        middleLabel.font = UIFont.ceraPro(size: 24)
        bottomLabel.font = UIFont.ceraPro(size: 24)
        topLabel.textColor = .white
        middleLabel.textColor = .white
        bottomLabel.textColor = .white
        topLabel.text = "Top"
        middleLabel.text = "Middle"
        bottomLabel.text = "Bottom"
        blurView.effect = UIBlurEffect(style: .dark)
        addSubview(blurView)
        blurView.contentView.addSubview(topLabel)
        blurView.contentView.addSubview(middleLabel)
        blurView.contentView.addSubview(bottomLabel)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }

        middleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        bottomLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        let panGesture = InstantPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePan(recognizer:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startAnimationIfNeeded()
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
        case .changed:
            var fraction = -recognizer.translation(in: self).y / closedTransform.ty
            if isOpen { fraction *= -1 }
            if animator.isReversed { fraction *= -1 }
            animator.fractionComplete = fraction + animationProgress
        // TODO: - Rubberbanding
        case .ended:
            let yVelocity = recognizer.velocity(in: self).y
            let shouldClose = yVelocity > 0
            if yVelocity == 0 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            if isOpen {
                if !shouldClose && !animator.isReversed { animator.isReversed.toggle() }
                if shouldClose && animator.isReversed { animator.isReversed.toggle() }
            }
            else {
                if shouldClose && !animator.isReversed { animator.isReversed.toggle() }
                if !shouldClose && animator.isReversed { animator.isReversed.toggle() }
            }
            let fractionRemaining = 1 - animator.fractionComplete
            let distanceRemaining = fractionRemaining * closedTransform.ty
            if distanceRemaining == 0 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            let relativeVelocity = min(abs(yVelocity) / distanceRemaining, 30)
            let timingParams = UISpringTimingParameters(damping: 0.8, response: 0.3, initialVelocity: CGVector(dx: relativeVelocity, dy: relativeVelocity))
            let preferredDuration = UIViewPropertyAnimator(duration: 0, timingParameters: timingParams).duration
            let durationFactor = CGFloat(preferredDuration / animator.duration)
            animator.continueAnimation(withTimingParameters: timingParams, durationFactor: durationFactor)
        default:
            break
        }
    }
    
    private func startAnimationIfNeeded() {
        if animator.isRunning { return }
        let timingParameters = UISpringTimingParameters(damping: 1, response: 0.4)
        animator = UIViewPropertyAnimator(duration: 0, timingParameters: timingParameters)
        animator.addAnimations {
            self.transform = self.isOpen ? self.closedTransform : .identity
        }
        animator.addCompletion { position in
            if position == .end { self.isOpen.toggle() }
        }
        animator.startAnimation()
    }
}
