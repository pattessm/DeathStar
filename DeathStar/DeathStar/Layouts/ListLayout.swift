//
//  ListLayout.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/31/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit

class ListLayout: UICollectionViewFlowLayout {
    
    let itemHeight: CGFloat = 200.0
    
    override init() {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override var itemSize: CGSize {
        get {
            guard let collectionView = collectionView else {return CGSize(width: 0.0, height: 0.0)}
            return CGSize(width: collectionView.frame.size.width, height: 200.0)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
}
