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
    
    func getCards()-> [Card]{
        (1 ... 36).forEach { _ in cards.append(Card()) }
        return cards
    }
}
