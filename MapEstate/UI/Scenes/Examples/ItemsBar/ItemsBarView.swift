//
//  ItemsBarView.swift
//  HeatNL
//
//  Created by Laurentiu Ungur on 19/04/2018.
//  Copyright © 2018 P3 Digital Services. All rights reserved.
//

import UIKit
//import PTFoundation

final class ItemsBarView: UIView {
    // MARK: - Properties
    
    var color = UIColor.init(white: 1, alpha: 0.6) {
        didSet {
            dottedLines.forEach { $0.dotColor = color }
        }
    }
    var indexOfSelectedItem = 0 {
        didSet {
            for (index, label) in labels.enumerated() {
                if index < indexOfSelectedItem { label.state = .checked }
                if index == indexOfSelectedItem { label.state = .current }
                if index > indexOfSelectedItem { label.state = .next }
            }
        }
    }
    
    private let texts: [String]
    private var labels = [RoundedLabelView]()
    private var dottedLines = [HorizontalDottedLine]()
    
    // MARK: - Init
    
    init(texts: [String]) {
        self.texts = texts
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        let labelSize = CGSize(width: 22, height: 22)
        let lineSize = CGSize(width: 30, height: 2)
        
        for (index, text) in texts.enumerated() {
            let label = RoundedLabelView()
            label.text = text
            labels.append(label)
            addSubview(label)
            
            label.snp.makeConstraints {
                $0.size.equalTo(labelSize)
                $0.top.bottom.equalToSuperview()
                if index == 0 {
                    $0.leading.equalToSuperview()
                } else if index == texts.count - 1 {
                    $0.trailing.equalToSuperview()
                    $0.leading.equalTo(dottedLines[index - 1].snp.trailing)
                } else {
                    $0.leading.equalTo(dottedLines[index - 1].snp.trailing)
                }
            }
            
            if index < texts.count - 1 {
                let dottedLine = HorizontalDottedLine()
                dottedLine.dotColor = color
                dottedLines.append(dottedLine)
                addSubview(dottedLine)
                
                dottedLine.snp.makeConstraints {
                    $0.size.equalTo(lineSize)
                    $0.centerY.equalTo(label)
                    $0.leading.equalTo(label.snp.trailing)
                }
            }
        }
    }
}
