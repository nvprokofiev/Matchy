//
//  GameInteractor.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameInteractor {
    
    private var cards: [Card] = []
    
    private(set) var score: Int = 0
    private var gameLevel = GameLevel()
    private var presenter: GamePresenter
    
    var flipsUsed: Int = 0
    lazy var flipsLeft: Int = gameLevel.initialFlipsValue
    
    private var flippedCard: Card?
    
    init(presenter: GamePresenter) {
        self.presenter = presenter
    }

    //MARK: - Callbacks
    var cardsMatched: (() -> Void)?
    var flipCardsBack: (() -> Void)?
    var gameOver: (() -> Void)?
    var playAgain: (() -> Void)?
    
    func start() {
        cards = getCardSet()
    }
    
    private func getCardSet()-> [Card] {
        CardIdentifierFactory.reset()
        gameLevel.levelUp()
        gameLevel.levelUp()
        gameLevel.levelUp()
        gameLevel.levelUp()

        cards = (1 ... gameLevel.pairsNumber).map { _ in Card() }
        
        cards.forEach{ cards.append($0.copy()) }
//        cards.shuffle()
    
        return cards
    }
    
    func getCards()-> [Card] {
        return cards
    }
    
    func flip(_ card: Card){
  
        guard let flippedCard = flippedCard else {
            self.flippedCard = card
            return
        }
        
        if flippedCard == card {
            score += 1
            flipsLeft += gameLevel.flipsBump
            flipsUsed += 1
            cardsMatched?()
        } else {
            flipsLeft -= 1
            flipsUsed += 1
            flipCardsBack?()
        }
        self.flippedCard = nil
        checkForGameOver()
    }
    
    private func checkForGameOver() {
        if flipsLeft == 0 {
            gameOver?()
        }
    }

}
