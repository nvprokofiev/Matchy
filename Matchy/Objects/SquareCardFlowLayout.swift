//
//  SquareCardFlowLayout.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

struct SquareCardFlowLayout {
    
    private let collectionView: UICollectionView
    
    init(for collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInset
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.itemSize = itemSize
        return layout
    }
    
    private let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    private let spacing: CGFloat = 8
    private var itemSize: CGSize {
        let mainWidth = collectionView.frame.width
        let totalHorizontalSpacing = spacing * (CGFloat(numberOfColumns - 1))
        let sizeConstant = (mainWidth - sectionInset.left - sectionInset.right - totalHorizontalSpacing) / CGFloat(numberOfColumns)
        
        return CGSize(width: sizeConstant, height: sizeConstant)
    }
    
    private var numberOfColumns: Int {
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        return Int(sqrt(Double(numberOfItems)))
    }
}
