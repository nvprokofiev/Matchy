//
//  CardCollectionViewCell.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    private var cardView: CardView = {
       let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    weak var cardCellDelegate: CardCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCardView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addCardView()
    }
    
    private func addCardView() {
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        cardView.frame = self.frame
    }

    func configure(by card: Card, with delegate: CardCellDelegate?) {
        cardView.configure(by: card)
        cardCellDelegate = delegate
        cardView.delegate = self
    }
    
    func hide(){
        cardView.hide()
    }
    
    func close(){
        cardView.close()
    }
    
    func showAndHide(){
        cardView.showAndHide()
    }
}

extension CardCollectionViewCell: CardDelegate {
    func didFlip(_ card: Card) {
        cardCellDelegate?.didFlip(card: card, in: self)
    }
}
