//
//  ExampleCell.swift
//  MapEstate
//
//  Created by Vlad on 03/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import SnapKit

final class ExampleCell: UITableViewCell {
    // MARK: - Properties
    var viewModel: ExampleCellViewModel? {
        didSet {
            
            guard let viewModel = viewModel else { return }
            title.text = viewModel.title
            icon.image = viewModel.icon
        }
    }
    
    private let title = UILabel()
    private let icon = UIImageView()
    private var gradientLayer = CAGradientLayer()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.blueishBlack
        contentView.layer.cornerRadius = 10
    
        contentView.addSubview(title)
        contentView.addSubview(icon)
        
        title.font = UIFont.ceraPro(size: 17)
        title.textColor = .white
        
        title.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(30)
        }
        
        icon.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(10)
            $0.width.height.equalTo(50)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview()
        }
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap(recognizer:)))
        longTap.minimumPressDuration = 0.2
        contentView.addGestureRecognizer(longTap)
    }
    
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        
    }
    
    @objc private func handleLongTap(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            UIView.animate(withDuration: 0.2) { self.contentView.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)}
        case .ended:
            UIView.animate(withDuration: 0.2) { self.contentView.transform = CGAffineTransform.identity}
        default:
            break;
        }
    }
}
