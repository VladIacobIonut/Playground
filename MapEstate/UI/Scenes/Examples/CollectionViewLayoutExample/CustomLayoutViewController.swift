//
//  CustomLayoutViewController.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import SnapKit

class CustomLayoutViewController: UIViewController {
    // MARK:- Properties
    private let collectionViewLayout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        
        return layout
    }()
    private var collectionView: UICollectionView
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CustomCollectionViewLayout())
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: "BasicCell")
        
        super.init(nibName: nil, bundle: nil)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK :- ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.blueishBlack
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


// MARK: - CollectionViewDataSource

extension CustomLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath) as? BasicCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = "A state of trance 201\(indexPath.row)"
        cell.imageView.image = #imageLiteral(resourceName: "armin.jpeg")
        
        return cell
    }
}

// MARK: - UICollectionViewLayoutDelegate

extension CustomLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 400)
    }
}
