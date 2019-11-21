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

class CardView: UIView {
    
    var card: Card?
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
        applyTileStyle(colors: card.backColor)
    }
    
    private func initialSetup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(open)))
    }
    
    @objc private func open() {
        
        guard let card = card else { return }
        isUserInteractionEnabled = false
        
        FlipAnimator().open(self, onHalfComplete: {
            self.setGradientBackgroundColor(colors: card.faceColor)
        }, onComplete: {
            self.delegate?.didFlip(card)
        })
    }
    
    func close() {
        guard let card = card else { return }
        
        FlipAnimator().close(self, onHalfComplete: {
            self.setGradientBackgroundColor(colors: card.backColor)
        }, onComplete: {
            self.isUserInteractionEnabled = true
        })
    }
    
    func hide() {
        FlipAnimator().hide(self)
    }
    
    func show() {
        guard let card = card else { return }

        FlipAnimator().show(self, onHalfComplete: {
            self.setGradientBackgroundColor(colors: card.faceColor)
        }, onComplete: {
            self.setGradientBackgroundColor(colors: card.backColor)
        })
    }
    
    func showAndHide(){
        guard let card = card else { return }

        FlipAnimator().showHide(self, onHalfComplete: {
            self.setGradientBackgroundColor(colors: card.faceColor)
        })
    }
}
