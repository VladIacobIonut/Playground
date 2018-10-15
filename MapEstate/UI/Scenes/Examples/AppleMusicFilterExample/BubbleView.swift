//
//  BubbleView.swift
//  MapEstate
//
//  Created by Vlad on 04/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class BubbleView: UIView {
    // MARK: - Properties
    
    private var isSelected: Bool = false
    private let filterLabel = UILabel()
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
    
    override var collisionBoundingPath: UIBezierPath {
        return UIBezierPath.init(ovalIn: bounds)
    }
    
    // MARK: - Init
    
    init(type: String) {
        super.init(frame: .zero)
        
        filterLabel.text = type
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        addSubview(filterLabel)
        filterLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        filterLabel.textColor = .white
        filterLabel.font = UIFont.ceraPro(size: 17)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    @objc private func tapped() {
        isSelected.toggle()
        backgroundColor = isSelected ? .white : .appleMusicRed
        filterLabel.textColor = isSelected ? .appleMusicRed : .white
    }
}
