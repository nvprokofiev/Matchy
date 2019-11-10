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
    private var cards: [Card] {
        return gameInteractor.getCards()
    }
    
    var level: Int {
        return gameInteractor.gameLevel.level
    }

    func viewDidLoad() {
        gameInteractor.start()
        gameInteractor.flipCardsBack = flipCardsBack
        gameInteractor.gameOver = gameOver
        gameInteractor.cardsMatched = cardsMatched
        gameInteractor.levelUp = levelUp
        
        view?.startNewLevel(with: cards)
        updateFlipsLabels()
    }
    
    private func flipCardsBack() {
        view?.flipCardsBack()
    }
    
    private func gameOver() {
        view?.gameOver()
    }
    
    func playAgain() {
        gameInteractor.playAgain()
        view?.startNewLevel(with: cards)
    }
    
    private func levelUp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            self.view?.startNewLevel(with: self.cards)
        })
    }
    
    private func cardsMatched(){
        view?.cardsMatched()
        view?.updateScoreLabel(with: gameInteractor.score)
    }
    
    private func updateFlipsLabels() {
        view?.updateFlipsLeftLabel(with: gameInteractor.flipsLeft)
        view?.updateFlipsUsedLabel(with: gameInteractor.flipsUsed)
    }
}

extension GamePresenter: CardDelegate {
    
    func didFlip(_ card: Card) {
        view?.didFlip(card)
        gameInteractor.flip(card)
        updateFlipsLabels()
    }
}
