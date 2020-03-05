//
//  StretchyHeaderLayout.swift
//  DragVisualEffect
//
//  Created by Elser_10 on 3/4/20.
//  Copyright © 2020 Elser_10. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                
                guard let cv = self.collectionView else { return }
                // offset is it lets you move the item related to that natural position.
                let contentOffsetY = cv.contentOffset.y
                //print(contentOffsetY)
                
                // to prevent collectionView from disappearing behind the header
                if contentOffsetY > 0 {
                    return
                }
                
                let height = attributes.frame.height - contentOffsetY
//                print(height)
                
                // when y is contentOffsetY it will be make stuck for the image, coz contentOffsetY is a negative value when dragging down, although you drag down, it should go upward for the negative value, coz the value is negative, but it stops at the origin to make the balance.
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: cv.frame.width, height: height)
            }
            
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
