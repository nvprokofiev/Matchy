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
    var gameLevel = GameLevel()
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
    var levelUp: (() -> Void)?

    func start() {
        cards = getCardSet()
    }
    
    private func getCardSet()-> [Card] {
        CardIdentifierFactory.reset()

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
            [flippedCard, card].forEach { $0.isMatched = true }
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
        checkForEndLevel()
    }
    
    private func checkForEndLevel() {
        if score == cards.count / 2 {
            gameLevel.levelUp()
            start()
            levelUp?()
        } else if flipsLeft == 0 {
            gameOver?()
        }
    }

}
