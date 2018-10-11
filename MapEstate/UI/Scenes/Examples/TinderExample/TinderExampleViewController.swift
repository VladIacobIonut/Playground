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
    private var collectionView: UICollectionView
    private var months = ["January", "February", "March", "April", "May", "June", "July", "August"]
    private let collectionViewLayout = TinderCollectionViewLayout()
    // MARK: - Init
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(BasicSpringlyCollectionViewCell.self, forCellWithReuseIdentifier: "BasicCell")
        
        super.init(nibName: nil, bundle: nil)
        
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.blueishBlack
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isScrollEnabled = false
    }
}


// MARK: - CollectionViewDataSource

extension TinderExampleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath) as? BasicSpringlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = months[indexPath.row]
        cell.shouldDismiss = {
            self.months.removeFirst()
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])
            }, completion: { completed in
               self.collectionViewLayout.invalidateLayout()
               self.collectionView.reloadData()
            })
        }
        
        return cell
    }
}

// MARK: - UICollectionViewLayoutDelegate

extension TinderExampleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 400)
    }
}
