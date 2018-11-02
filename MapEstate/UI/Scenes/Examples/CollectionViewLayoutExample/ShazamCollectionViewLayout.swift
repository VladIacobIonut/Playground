//
//  CustomCollectionViewLayout.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class ShazamCollectionViewLayout: UICollectionViewFlowLayout {
     // MARK: - Properties
    
    private var firstSetupDone = false
    private let smallItemScale: CGFloat = 0.2
    private let smallItemAlpha: CGFloat = 0.7
    private let firstItemTransform: CGFloat = 0.05
    private var isPagingEnabled = true
    
     // MARK: - Override
    
    override func prepare() {
        super.prepare()
        
        guard !firstSetupDone else { return }
        setup()
        firstSetupDone = true
    }
    
    func setup() {
        scrollDirection = .vertical
        minimumLineSpacing = 30
        itemSize = CGSize(width: collectionView!.bounds.width - 20, height: collectionView!.bounds.height - 100)
        collectionView!.decelerationRate = UIScrollView.DecelerationRate.normal
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // If the property `isPagingEnabled` is set to false, we don't enable paging and thus return the current contentoffset.
        guard isPagingEnabled else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        // Page height used for estimating and calculating paging.
        let pageHeight = collectionView!.bounds.height - 100 + self.minimumLineSpacing
        
        // Make an estimation of the current page position.
        let approximatePage = self.collectionView!.contentOffset.y/pageHeight
        
        // Determine the current page based on velocity.
        let currentPage = (velocity.y < 0.0) ? floor(approximatePage) : ceil(approximatePage)
        
        // Create custom flickVelocity.
        let flickVelocity = velocity.y * 0.4
        
        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
        
        // Calculate newVerticalOffset.
        let newVerticalOffset = ((currentPage + flickedPages) * pageHeight) - self.collectionView!.contentInset.top
        
        return CGPoint(x: proposedContentOffset.x, y: newVerticalOffset)
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // make sure the zIndex of the next card is higher than the one we're swiping away.
        let nextIndexPath = IndexPath(row: itemIndexPath.row + 1, section: itemIndexPath.section)
        let nextAttr = self.layoutAttributesForItem(at: nextIndexPath)
        nextAttr?.zIndex = nextIndexPath.row
        
        // attributes for swiping card away
        let attr = self.layoutAttributesForItem(at: itemIndexPath)
        
        return attr
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let allAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attributes in allAttributes {
            self.updateCellAttributes(attributes)
        }
        
        return allAttributes
    }
    
    /**
     Updates the attributes.
     Here manipulate the zIndex of the cards here, calculate the positions and do the animations.
     - parameter attributes: The attributes we're updating.
     */
    fileprivate func updateCellAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let minY = collectionView!.bounds.minY + collectionView!.contentInset.top
        let maxY = attributes.frame.origin.y
        
        let finalY = max(minY, maxY)
        var origin = attributes.frame.origin
        let deltaY = (finalY - origin.y) / attributes.frame.height
        
        let translationScale = CGFloat((attributes.zIndex + 1) * 10)
        
        let scale = 1 - deltaY * firstItemTransform
        var t = CGAffineTransform.identity
        t = t.scaledBy(x: scale, y: 1)
        t = t.translatedBy(x: 0, y: (translationScale + deltaY * translationScale))
        
        attributes.alpha = 1 - deltaY + 0.6
        attributes.transform = t
        
        origin.x = (self.collectionView?.frame.width)! / 2 - attributes.frame.width / 2 - (self.collectionView?.contentInset.left)!
        origin.y = finalY
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
        attributes.zIndex = attributes.indexPath.row
    }
}
