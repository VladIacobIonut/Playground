//
//  BasicCollectionViewCell.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let label = UILabel()
    let imageView = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    private func setupUI() {
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor.randomColor()
                
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        label.font = UIFont.ceraPro(size: 34)
        label.textColor = UIColor.white
    }
}
