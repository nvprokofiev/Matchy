//
//  GameCollectionViewDataSource.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    typealias DataModel = [Card]
    private var cards: DataModel
    private let contentInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    var numberOfColumns = 8
    
    init(data: DataModel) {
      self.cards = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCollectionViewCell.self), for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.item]
        cell.configure(by: card)

        return cell
    }
}

extension GameCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentInsetsCalculator = SquareContentInsetsCalculator(for: collectionView, with: contentInsets)
        return contentInsetsCalculator.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let contentInsetsCalculator = SquareContentInsetsCalculator(for: collectionView, with: contentInsets)
        return contentInsetsCalculator.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      let contentInsetsCalculator = SquareContentInsetsCalculator(for: collectionView, with: contentInsets)
      return contentInsetsCalculator.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return contentInsets
    }
}

struct SquareContentInsetsCalculator {
    
    var collectionView: UICollectionView
    private var insets: UIEdgeInsets

    init(for collectionView: UICollectionView, with insets: UIEdgeInsets) {
        self.collectionView = collectionView
        self.insets = insets
    }

    var numberOfColumns: Int {
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        return Int(sqrt(Double(numberOfItems)))
    }

    var spacing: CGFloat {
         return (insets.top + insets.bottom) / 2
     }

    var cellSize: CGSize {
        let mainWidth = collectionView.frame.width
        let totalHorizontalSpacing = spacing * (CGFloat(numberOfColumns - 1))
        let sizeConstant = (mainWidth - insets.left - insets.right - totalHorizontalSpacing) / CGFloat(numberOfColumns)
        return CGSize(width: sizeConstant, height: sizeConstant)
    }
}
