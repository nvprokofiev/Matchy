//
//  GameViewController.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    var cards: [Card] = []
    private let presenter = GamePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CardCollectionViewCell.self))
        setupPresenter()
    }
    
    private func setupPresenter() {
        presenter.view = self
        presenter.viewDidLoad()
        presenter.setDelegateAndDataSource(for: collectionView)
    }
}
