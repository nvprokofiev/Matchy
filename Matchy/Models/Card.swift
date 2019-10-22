//
//  Card.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class Card: Equatable {
    
    private(set) var id: Int
    private(set) var faceColor: TwoColorsGradient
    private(set) var backColor: TwoColorsGradient
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    
    init() {
        self.id = CardIdentifierFactory.getUniqueId()
        self.faceColor = Gradients().randomColorSet()
        self.backColor = Gradients().defaultColorSet()
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    func copy(with zone: NSZone? = nil) -> Card {
        let copy = Card()
        copy.id = id
        copy.faceColor = faceColor
        copy.backColor = backColor
        return copy
    }
}
