//
//  HorizontalScaleCollectionViewLayout.swift
//  MapEstate
//
//  Created by Vlad on 10/29/18.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class HorizontalScaleCollectionViewLayout: UICollectionViewFlowLayout {
    // MARK: - Properties
    
    private var firstSetupDone = false
    private var isPagingEnabled = true
    private lazy var cellWidth = collectionView!.bounds.width - 40
    private lazy var cellHeight = collectionView!.bounds.height - 100
    
    // MARK: - Override
    
    override func prepare() {
        super.prepare()
        
        guard !firstSetupDone else {
            return
        }
        setup()
        firstSetupDone = true
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    internal override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        // If the property `isPagingEnabled` is set to false, we don't enable paging and thus return the current contentoffset.
        guard isPagingEnabled else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        // Page width used for estimating and calculating paging
        
        let pageWidth = cellWidth + self.minimumInteritemSpacing
        
        // Make an estimation of the current page position.
        let approximatePage = self.collectionView!.contentOffset.x/pageWidth
        
        // Determine the current page based on velocity.
        let currentPage = (velocity.x < 0.0) ? floor(approximatePage) : ceil(approximatePage)
        
        // Create custom flickVelocity.
        let flickVelocity = velocity.x * 0.4
        
        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
        
        // Calculate newHorizontalOffset
        
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - self.collectionView!.contentInset.left
        
        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.x)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let items = NSMutableArray (array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        
        items.enumerateObjects { (object, index, stop) in
            let attribute = object as! UICollectionViewLayoutAttributes
            
            self.updateCellAttributes(attribute: attribute)
        }
        
        return items as? [UICollectionViewLayoutAttributes]
    }
    
    // MARK: - Private functions
    
    private func setup() {
        scrollDirection = .horizontal
        minimumInteritemSpacing = 10
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private func updateCellAttributes(attribute: UICollectionViewLayoutAttributes) {
        var finalX: CGFloat = attribute.frame.midX - (collectionView?.contentOffset.x)!
        let centerX = attribute.frame.midX - (collectionView?.contentOffset.x)!
        if centerX < collectionView!.frame.midX - 20 {
            finalX = max(centerX, collectionView!.frame.minX)
        }
        else if centerX > collectionView!.frame.midX + 20 {
            finalX = min(centerX, collectionView!.frame.maxX)
        }
        
        let deltaY = abs(finalX - collectionView!.frame.midX) / attribute.frame.width
        let scale = 1 - deltaY * 0.2
        let alpha = 1 - deltaY
        
        attribute.alpha = alpha
        attribute.transform = CGAffineTransform(scaleX: 1, y: scale)
    }
}
