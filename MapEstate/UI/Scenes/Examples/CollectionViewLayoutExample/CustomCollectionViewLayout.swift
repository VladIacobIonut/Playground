//
//  CustomCollectionViewLayout.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class CustomCollectionViewLayout: UICollectionViewFlowLayout {
     // MARK: - Properties
    
    private var firstSetupDone = false
    private let smallItemScale: CGFloat = 0.2
    private let smallItemAlpha: CGFloat = 0.7
    
     // MARK: - Override
    
    override func prepare() {
        super.prepare()
        
        guard !firstSetupDone else { return }
        setup()
        firstSetupDone = true
    }
    
    func setup() {
        scrollDirection = .vertical
        minimumLineSpacing = 20
        itemSize = CGSize(width: collectionView!.bounds.width, height: collectionView!.bounds.height - 200)
        collectionView!.decelerationRate = UIScrollView.DecelerationRate.normal
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let layoutAttributes = layoutAttributesForElements(in: collectionView!.bounds)
        
        let centerOffset = collectionView!.bounds.size.height / 2
        let offsetWithCenter = proposedContentOffset.y + centerOffset
        
        let closestAttribute = layoutAttributes!
            .sorted { abs($0.center.y - offsetWithCenter) < abs($1.center.y - offsetWithCenter) }
            .first ?? UICollectionViewLayoutAttributes()
        
        return CGPoint(x: 0, y: closestAttribute.center.y - centerOffset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let allAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attributes in allAttributes {
            let collectionViewTop = collectionView!.bounds.minY + 80
            let offset = collectionView!.contentOffset.y
            let normalizedCenter = attributes.center.y - offset
        }
        
        return allAttributes
    }
}
