//
//  TinderCollectionViewLayout.swift
//  MapEstate
//
//  Created by Vlad on 05/10/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class TinderCollectionViewLayout: UICollectionViewFlowLayout {
    // MARK: - Properties
    
    private var firstSetupDone = false
    private let smallItemScale: CGFloat = 0.2
    private let smallItemAlpha: CGFloat = 0.7
    private let firstItemTransform: CGFloat = 0.3
    private var lastFrame: CGRect = .zero
    
    // MARK: - Override
    
    override func prepare() {
        super.prepare()
        
        guard !firstSetupDone else { return }
        setup()
        firstSetupDone = true
        setup()
    }
    
    func setup() {
        itemSize = CGSize(width: collectionView!.bounds.width - 20, height: collectionView!.bounds.height - 100)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let allAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attributes in allAttributes {
            self.updateCellAttributes(attributes)
        }
        
        return allAttributes
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let nextIndexPath = IndexPath(item: itemIndexPath.item, section: itemIndexPath.section)
        let nextAttr = self.layoutAttributesForItem(at: nextIndexPath)
    
        nextAttr?.frame = lastFrame
        nextAttr?.zIndex = -nextIndexPath.item
        nextAttr?.alpha = 1
    
        return nextAttr
    }
    
    /**
     Updates the attributes.
     Here manipulate the zIndex of the cards here, calculate the positions and do the animations.
     - parameter attributes: The attributes we're updating.
     */
    fileprivate func updateCellAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        attributes.zIndex = -attributes.indexPath.row
        
        var origin = attributes.frame.origin
        let translation = CGFloat((attributes.indexPath.row + 1) * 10)
        let deltaZ = CGFloat(attributes.indexPath.row) / 10

        let scale = 1 - deltaZ * 0.5
        var t = CGAffineTransform.identity
//        t = t.scaledBy(x: scale, y: 1)
        t = t.translatedBy(x: 0, y: (translation + deltaZ * translation))
        attributes.transform = t
        
        origin.x = (self.collectionView?.frame.width)! / 2 - attributes.frame.width / 2 - (self.collectionView?.contentInset.left)!
        t = t.scaledBy(x: scale, y: 1)
        origin.y = collectionView!.bounds.minY + collectionView!.contentInset.top
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)

        lastFrame = attributes.frame
    }
}
