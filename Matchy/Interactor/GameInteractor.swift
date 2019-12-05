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
    
    private(set) var score = 0
    private var levelScore = 0
    var gameLevel = GameLevel()
    private var presenter: GamePresenter
        
    var flipsUsed = 0
    var flipsLeft = 0
    
    private var flippedCard: Card?
    
    init(presenter: GamePresenter) {
        self.presenter = presenter
    }

    //MARK: - Callbacks
    var cardsMatched: (() -> Void)?
    var flipCardsBack: (() -> Void)?
    var gameOver: (() -> Void)?
    var levelUp: (() -> Void)?

    func start() {
        levelScore = 0
        flipsUsed = 0
        flipsLeft += gameLevel.value
        cards = getCardSet()
    }
    
    func playAgain() {
        gameLevel.reset()
        start()
    }
    
    private func getCardSet()-> [Card] {
        CardIdentifierFactory.reset()

        cards = (1 ... gameLevel.value).map { _ in Card() }
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
            levelScore += 1
            
            //FIXME:-
            flipsLeft += 1
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
        if levelScore == cards.count / 2 {
            gameLevel.levelUp()
            start()
            levelUp?()
        } else if flipsLeft <= 0 {
            flipsLeft = 0
            gameOver?()
        }
    }
}
