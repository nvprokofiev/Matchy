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
    @IBOutlet private weak var scoreView: ScoreView!
    @IBOutlet private weak var flipsLeftView: TitledTileView!
    @IBOutlet private weak var flipsUsedView: TitledTileView!
        
    var cards: [Card] = []
    private let presenter = GamePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CardCollectionViewCell.self))
        setupPresenter()
        collectionView.setCollectionViewLayout(SquareCardFlowLayout(for: collectionView).layout, animated: true)
        
        flipsLeftView.setTitle("Left")
        flipsUsedView.setTitle("Attemps")
    }
    
    private func setupPresenter() {
        presenter.view = self
        presenter.viewDidLoad()
        presenter.setDelegateAndDataSource(for: collectionView)
    }
    
    func flipCardsBack(){
        
    }
    
    func cardsMatched() {
    }
    
    func gameOver() {
        print(#function)
    }
    
    func playAgain() {
        
    }
    
//    func reloadCells(_ cells: [CardCollectionViewCell]) {
//        let indexPaths: [IndexPath] = cells.compactMap { (collectionView.indexPath(for: $0))}
//        collectionView.reloadItems(at: indexPaths)
//    }
        
    func reloadData() {
        collectionView.reloadData()
    }
    
    func updateFlipsLeftLabel(with value: Int){
        flipsLeftView.value = value
    }
    
    func updateFlipsUsedLabel(with value: Int){
        flipsUsedView.value = value
    }
    
    func updateScoreLabel(with value: Int) {
        scoreView.value = value
    }
}
