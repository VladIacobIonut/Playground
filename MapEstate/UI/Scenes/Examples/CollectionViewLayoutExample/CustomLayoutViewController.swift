//
//  CustomLayoutViewController.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class CustomLayoutViewController: UIViewController {
    // MARK: - Properties
    
    private lazy var cellHeight = Int(collectionView.bounds.height - 100)
    private lazy var cellWidth = Int(collectionView.bounds.width - 40)
    private var collectionView: UICollectionView
    private var currentCollectionViewLayout: Layouts = .inflate
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: currentCollectionViewLayout.layout)
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: "BasicCell")
        
        super.init(nibName: nil, bundle: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController
    
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
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
        }
        
        let change = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(invalidateLayout))
        navigationItem.rightBarButtonItem = change
    }
    
    @objc private func invalidateLayout() {
        let horizontalLayout = UICollectionViewFlowLayout()
        horizontalLayout.scrollDirection = .vertical
        horizontalLayout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(currentCollectionViewLayout.next.layout, animated: true)
        currentCollectionViewLayout = currentCollectionViewLayout.next
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
        
        cell.label.text = "October \(indexPath.row + 1)"
        
        return cell
    }
}

// MARK: - UICollectionViewLayoutDelegate

extension CustomLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

enum Layouts {
    case inflate
    case shazam
    case vertical
    
    var next: Layouts {
        switch self {
        case .inflate:
            return .shazam
        case .shazam:
            return .vertical
        case .vertical:
            return .inflate
        }
    }
    
    var layout: UICollectionViewLayout {
        switch self {
        case .inflate:
            return HorizontalScaleCollectionViewLayout()
        case .shazam:
            return ShazamCollectionViewLayout()
        case .vertical:
            return UICollectionViewFlowLayout()
        }
    }
}
