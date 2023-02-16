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
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        if let center = attrs?.center {
            let offset = boundsView != nil ? boundsView?.frame.width : offsetIfBoundsViewNotProvided
            attrs?.center = CGPoint(x: center.x + offset!, y: center.y)
        }
        attrs?.alpha = 1.0
        return attrs
    }
}
