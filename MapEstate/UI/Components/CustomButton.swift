//
//  CustomButton.swift
//  MapEstate
//
//  Created by Vlad on 02/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import SnapKit

class CustomButton: UIButton {
    // MARK: - Properties
    private var animator = UIViewPropertyAnimator()
    private var selectedColor = UIColor.blueishBlack
    private var unselectedColor = UIColor.seaGreen
    
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
        layer.cornerRadius = 20
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        backgroundColor = unselectedColor
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit])
    }
    
    @objc private func touchDown() {
        animator.stopAnimation(true)
        backgroundColor = selectedColor
    }
    
    @objc private func touchUp() {
        animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut, animations: {
            self.backgroundColor = self.unselectedColor
        })
        animator.startAnimation()
    }
}
