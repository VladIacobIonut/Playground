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
        let allAttributes = NSArray (array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        
        allAttributes.enumerateObjects { (object, index, stop) in
            let attributes = object as! UICollectionViewLayoutAttributes
            
            self.updateCellAttributes(attributes)
        }
        
        return allAttributes as? [UICollectionViewLayoutAttributes]
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let nextIndexPath = IndexPath(item: itemIndexPath.item, section: itemIndexPath.section)
        let nextAttr = self.layoutAttributesForItem(at: nextIndexPath)
        
        nextAttr?.frame = lastFrame
        nextAttr?.zIndex = -nextIndexPath.item
        if itemIndexPath.item != 0 {
            nextAttr?.alpha = 0.5
        }
    
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
        let translation = CGFloat((attributes.indexPath.row + 1) * 7)
        let deltaZ = CGFloat(attributes.indexPath.row) / 10

        var t = CGAffineTransform.identity
        t = t.translatedBy(x: 0, y: (translation + deltaZ * translation))
        attributes.alpha = 1 - deltaZ * 4
        attributes.transform = t
    
        let width = attributes.indexPath.row == 0 ? attributes.frame.width : attributes.frame.width - 30
        
        origin.x = (self.collectionView?.frame.width)! / 2 - width / 2 - (self.collectionView?.contentInset.left)!
        origin.y = collectionView!.bounds.minY + collectionView!.contentInset.top
        attributes.frame = CGRect(origin: origin, size: CGSize(width: width, height: attributes.frame.height))
        
        lastFrame = attributes.frame
    }
}
