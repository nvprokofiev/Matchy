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
    private lazy var gameInteractor = GameInteractor(presenter: self)
    private lazy var dataSource = GameCollectionViewDataSource(data: cards, delegate: self)
    private var cards: [Card] {
        return gameInteractor.getCards()
    }
    
    private var flippedCardItems: [CardCollectionViewCell] = []
        
    func viewDidLoad() {
        gameInteractor.start()
        gameInteractor.flipCardsBack = flipCardsBack
        gameInteractor.playAgain = playAgain
        gameInteractor.gameOver = gameOver
        gameInteractor.cardsMatched = cardsMatched
        
        dataSource.update(with: cards)
        view?.reloadData()
        updateFlipsLabels()
    }
    
    func setDelegateAndDataSource(for collectionView: UICollectionView) {
      collectionView.delegate = dataSource
      collectionView.dataSource = dataSource
    }
    
    private func flipCardsBack() {
        flippedCardItems.forEach { $0.close() }
        flippedCardItems = []
    }
    
    private func playAgain() {
        view?.playAgain()
    }
    
    private func gameOver() {
        view?.gameOver()
    }
    
    private func cardsMatched(){
        flippedCardItems.forEach { $0.hide() }
        flippedCardItems = []
        view?.updateScoreLabel(with: gameInteractor.score)
    }
    
    private func updateFlipsLabels() {
        view?.updateFlipsLeftLabel(with: gameInteractor.flipsLeft)
        view?.updateFlipsUsedLabel(with: gameInteractor.flipsUsed)
    }
}

extension GamePresenter: CardCellDelegate {
    
    func didFlip(card: Card, in cell: CardCollectionViewCell) {
        flippedCardItems.append(cell)
        gameInteractor.flip(card)
        updateFlipsLabels()
    }
}
