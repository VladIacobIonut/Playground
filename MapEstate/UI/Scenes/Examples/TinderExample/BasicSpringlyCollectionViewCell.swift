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
    private var swipingVelocityThreshold: CGFloat = 800
    private var rotationDegreeRatio: CGFloat = 0.50
    private var divisor: CGFloat = 0
    private var initialCenter: CGPoint = .zero
    private var swipeableView = UIView()
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialCenter = self.contentView.center
        divisor = contentView.frame.width / rotationDegreeRatio
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.swipeableView.transform = CGAffineTransform.identity
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        contentView.addSubview(swipeableView)
        swipeableView.clipsToBounds = true
        swipeableView.backgroundColor = UIColor.randomColor()
        swipeableView.layer.cornerRadius = 25
        
        swipeableView.addSubview(label)
        swipeableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        label.font = UIFont.ceraPro(size: 34)
        label.textColor = UIColor.white
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        swipeableView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: self)
        let xFromCenter = swipeableView.center.x - center.x
        let scale = min(100 / abs(xFromCenter), 1)
        switch recognizer.state {
        case .began:
            initialOffset = CGPoint(x: touchPoint.x - swipeableView.center.x, y: touchPoint.y - swipeableView.center.y)
        case .changed:
            swipeableView.center = CGPoint(x: touchPoint.x - initialOffset.x, y: touchPoint.y - initialOffset.y)
            swipeableView.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor).scaledBy(x: scale, y: scale)
        case .ended, .cancelled:
            handleSwipeEnding(for: recognizer.velocity(in: self).x)
        default:
            return
        }
    }
    
    private func handleSwipeEnding(for xVelocity: CGFloat) {
        let velocity = abs(xVelocity)
        guard velocity > swipingVelocityThreshold else {
            moveCardToInitialState()
            return
        }
        
        swipeCardAway(with: xVelocity)
    }
    
    private func moveCardToInitialState() {
        UIView.animate(withDuration: 0.2) {
            self.swipeableView.center = self.center
        }
        
        swipeableView.transform = CGAffineTransform.identity
    }
    
    private func swipeCardAway(with xVelocity: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.swipeableView.center = CGPoint(x: self.swipeableView.center.x + xVelocity, y: self.swipeableView.center.y)
        }
        
        shouldDismiss?()
    }
}

