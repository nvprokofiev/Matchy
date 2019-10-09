//
//  GamePresenter.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GamePresenter: NSObject {
    
    weak var view: GameViewController?
    private let gameInteractor = GameInteractor()
    private var cards: [Card] {
      return gameInteractor.getCards()
    }
    private lazy var dataSource = GameCollectionViewDataSource(data: cards)
    
    func viewDidLoad() {

    }
    
    func setDelegateAndDataSource(for collectionView: UICollectionView) {
      collectionView.delegate = dataSource
      collectionView.dataSource = dataSource
    }
}
