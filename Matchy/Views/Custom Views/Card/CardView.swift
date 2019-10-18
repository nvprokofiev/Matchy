//
//  CardView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

protocol CardDelegate: class {
  func didFlip(_ card: Card)
}

class CardView: UIView, StyleHelper {
    
    private var card: Card?
    weak var delegate: CardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    func configure(by card: Card) {
        self.card = card
        applyStyle(to: self, colors: card.backColor)
    }
    
    private func initialSetup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flip)))
    }
    
    @objc private func flip(){
        guard let card = card else { return }
        card.isFaceUp ? closeCard() : openCard()
        delegate?.didFlip(card)
    }
    
    private func openCard() {
        card?.isFaceUp.toggle()
        guard let card = card else { return }
//        isUserInteractionEnabled = false
        FlipAnimator(view: self, type: .open).animate {
            self.setGradientBackgroundColor(to: self, colors: card.faceColor)
        }
    }
    
    private func closeCard() {
        card?.isFaceUp.toggle()
        guard let card = card else { return }
//        self.isUserInteractionEnabled = true
        FlipAnimator(view: self, type: .close).animate {
            self.setGradientBackgroundColor(to: self, colors: card.backColor)
        }
    }
    
    private func hide() {
        isUserInteractionEnabled = false
        FlipAnimator(view: self, type: .hide).animate {
            
        }
    }
    
}
