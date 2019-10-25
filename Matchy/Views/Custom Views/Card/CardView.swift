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
    
    private let delay: TimeInterval = 0.3
    
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
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(open)))
    }
    
    @objc private func open() {
        guard let card = card else { return }
        isUserInteractionEnabled = false
        FlipAnimator(view: self, type: .open).animate {
            self.setGradientBackgroundColor(to: self, colors: card.faceColor)
            self.delegate?.didFlip(card)
        }
    }
    
    func close() {
        guard let card = card else { return }
        FlipAnimator(view: self, type: .close).animate(delay: delay) {
            self.setGradientBackgroundColor(to: self, colors: card.backColor)
            self.isUserInteractionEnabled = true
        }
    }
    
    func hide() {
        FlipAnimator(view: self, type: .hide).animate(delay: delay) {
            
        }
    }
    
    func show() {
        guard let card = card else { return }
        
        FlipAnimator(view: self, type: .open).animate(delay: 1.2) {
            self.setGradientBackgroundColor(to: self, colors: card.faceColor)
        }.animate(delay: 2.4) {
            self.setGradientBackgroundColor(to: self, colors: card.backColor)
        }
    }
    
    func showAndHide(){
        guard let card = card, !card.isMatched else { return }
        
        FlipAnimator(view: self, type: .open).animate(delay: 1.2) {
            self.setGradientBackgroundColor(to: self, colors: card.faceColor)
        }.animate(delay: 2.4) {
            self.alpha = 0.0
        }
    }
}
