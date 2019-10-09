//
//  CardView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class CardView: UIView, StyleHelper {

    private var card: Card?

    func configure(by card: Card) {
        self.card = card
        setGradientBackgroundColor(to: self, colors: card.backColor)
        setCornerRadius(to: self)
        setShadow(to: self)
    }
}
