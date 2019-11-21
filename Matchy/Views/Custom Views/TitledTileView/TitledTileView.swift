//
//  ScoreView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TitledTileView: UIView {
    
    var title: String = String() {
        didSet {
            scoreLabel.text = title
        }
    }

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
        applyTileStyle()
        addTitleLabel()
    }

    private func addTitleLabel() {
        addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func setFont(_ font: UIFont){
        scoreLabel.font = font
    }
}
