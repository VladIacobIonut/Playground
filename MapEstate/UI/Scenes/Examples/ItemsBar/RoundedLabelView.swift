//
//  RoundedLabelView.swift
//  HeatNL
//
//  Created by Laurentiu Ungur on 19/04/2018.
//  Copyright © 2018 P3 Digital Services. All rights reserved.
//

import UIKit
import SnapKit

enum DotState {
    case checked
    case current
    case next
    
    var isLabelHidden: Bool {
        return self == .checked
    }
    
    var isCheckHidden: Bool {
        return self != .checked
    }
    
    var backgroundColor: UIColor {
        return self == .next ? UIColor(white: 1, alpha: 0.5) : UIColor.white
    }
}

final class RoundedLabelView: UIView {
    // MARK: - Properties
    
    var text: String? {
        didSet {
            label.text = text
        }
    }

    var state: DotState = .next {
        didSet {
            
            label.isHidden = state.isLabelHidden
            checkMark.isHidden = state.isCheckHidden
            backgroundColor = state.backgroundColor
        }
    }
    
    private let label = UILabel()
    private let checkMark = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(checkMark)
        
        checkMark.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        checkMark.image = UIImage(named: "stepDone")
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-1)
            $0.centerX.equalToSuperview()
        }
        label.textColor = UIColor.oceanBlue
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base Class Overrides
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = frame.size.width / 2
    }
}
