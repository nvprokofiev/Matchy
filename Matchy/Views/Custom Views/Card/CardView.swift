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

enum CardState {
    case open, close, hidden
}

class CardView: UIView {

    var card: Card?
    weak var delegate: CardDelegate?
    private var state: CardState = .close
    
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
        state = .open

        guard let card = card else { return }
        isUserInteractionEnabled = false
        
        FlipAnimator().open(self, onHalfComplete: {
            self.setGradientBackgroundColor(colors: card.faceColor)
        }, onComplete: {
            self.delegate?.didFlip(card)
        })
    }
    
    func close() {
        state = .close

        guard let card = card else { return }
        FlipAnimator().close(self, onHalfComplete: {
            self.setGradientBackgroundColor(colors: card.backColor)
        }, onComplete: {
            self.isUserInteractionEnabled = true
        })
    }
    
    func hide() {
        state = .hidden
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
        
        
        switch state {
        case .close:
            FlipAnimator().open(self, onHalfComplete: {
                self.setGradientBackgroundColor(colors: card.faceColor)
            })
        case .hidden:
            DispatchQueue.main.asyncAfter(deadline: .now() + FlipAnimationConstants.duration / 2, execute: {
                FlipAnimator().open(self, onHalfComplete: {
                    self.setGradientBackgroundColor(colors: card.faceColor)
                })
            })
        default:
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + FlipAnimationConstants.duration + FlipAnimationConstants.pause, execute: {
            FlipAnimator().hide(self)
        })
        

//        FlipAnimator().showHide(self, onHalfComplete: {
//            self.setGradientBackgroundColor(colors: card.faceColor)
//        })
    }
}
