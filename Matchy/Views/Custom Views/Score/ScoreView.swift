//
//  ScoreView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class ScoreView: UIView, StyleHelper {
    
    private var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        addCardView()
        addScoreLabel()
        styleCard()
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

    private func addScoreLabel() {
        cardView.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            scoreLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
            scoreLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
                scoreLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8)
        ])
    }
    
    private func styleCard() {
        setGradientBackgroundColor(to: self, colors: Gradients().randomColorSet())
        setCornerRadius(to: self)
        setShadow(to: self)
    }
}
