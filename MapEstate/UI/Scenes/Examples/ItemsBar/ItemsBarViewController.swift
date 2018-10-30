//
//  ItemsBarViewController.swift
//  MapEstate
//
//  Created by Vlad on 17/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class ItemsBarViewController: UIViewController {
    // MARK: - Properties

    private let itemsView = ItemsBarView(texts: (1...5).map{ "\($0)" })
    private let navigationView = UIView()
    private let incrementButton = UIButton()
    private let decrementButton = UIButton()
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blueishBlack
        navigationController?.navigationBar.isHidden = true
        
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.addSubview(navigationView)
        view.addSubview(incrementButton)
        view.addSubview(decrementButton)
        
        incrementButton.setTitle("Increment", for: .normal)
        decrementButton.setTitle("Decrement", for: .normal)
        
        incrementButton.backgroundColor = UIColor.oceanBlue
        decrementButton.backgroundColor = UIColor.oceanBlue
        
        navigationView.addSubview(itemsView)
        navigationView.backgroundColor = UIColor.oceanBlue
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        itemsView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        incrementButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-80)
            $0.height.equalTo(80)
            $0.width.equalTo(self.view.frame.width / 2)
        }
        
        decrementButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-80)
            $0.height.equalTo(80)
            $0.width.equalTo(self.view.frame.width / 2)
        }
        
        incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        
        itemsView.indexOfSelectedItem = 0
    }
    
    @objc private func increment() {
        itemsView.indexOfSelectedItem += 1
    }
    
    @objc private func decrement() {
        itemsView.indexOfSelectedItem -= 1
    }
}
