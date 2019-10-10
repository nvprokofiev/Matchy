//
//  ScoreView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class ScoreView: UIView, StyleHelper {
    
    private var tileView: TileView = {
        let view = TileView()
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
        addTileView()
        addScoreLabel()
    }
    
    private func addTileView() {
        addSubview(tileView)
        NSLayoutConstraint.activate([
            tileView.topAnchor.constraint(equalTo: topAnchor),
            tileView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tileView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tileView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func addScoreLabel() {
        tileView.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: tileView.topAnchor, constant: 8),
            scoreLabel.bottomAnchor.constraint(equalTo: tileView.bottomAnchor, constant: -8),
            scoreLabel.leadingAnchor.constraint(equalTo: tileView.leadingAnchor, constant: 8),
            scoreLabel.trailingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: -8)
        ])
        
    }
}
