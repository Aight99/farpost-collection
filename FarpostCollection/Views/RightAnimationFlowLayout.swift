//
//  RightAnimationFlowLayout.swift
//  FarpostCollection
//
//  Created by ios_developer on 17.02.2023.
//

import UIKit

class RightAnimationFlowLayout: UICollectionViewFlowLayout {
    
    let offsetIfBoundsViewNotProvided: CGFloat = 1000
    weak var boundsView: UIView?
    var lastIndexPath: IndexPath?
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        
        if itemIndexPath == lastIndexPath, let center = attributes?.center {
            let offset = boundsView != nil ? boundsView?.frame.width : offsetIfBoundsViewNotProvided
            attributes?.center = CGPoint(x: center.x + offset!, y: center.y)
            lastIndexPath = nil
        }
        
        attributes?.alpha = 1.0
        return attributes
    }
}
