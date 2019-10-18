//
//  GameCollectionViewDataSource.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

protocol CardCellDelegate: class {
    func didFlip(card: Card, in cell: CardCollectionViewCell)
}

class GameCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    typealias DataModel = [Card]
    private var cards: DataModel
    private weak var cellDelegate: CardCellDelegate?
    private let contentInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    init(data: DataModel, delegate: CardCellDelegate?) {
        self.cards = data
        self.cellDelegate = delegate
    }
    
    func update(with data: DataModel) {
        self.cards = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCollectionViewCell.self), for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.item]
        cell.configure(by: card, with: cellDelegate)
        return cell
    }
}
