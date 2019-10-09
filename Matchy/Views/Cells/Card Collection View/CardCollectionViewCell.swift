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

    func configure(by card: Card) {
        cardView.configure(by: card)
    }
}
