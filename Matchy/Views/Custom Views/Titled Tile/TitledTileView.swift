//
//  TitledCardView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TitledTileView: UIView, StyleHelper {
    
    private var value: Int = 0 {
        didSet {
            valueLabel.text = String(value)
        }
    }
        
    private var tileView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
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
        addTitleLabel()
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
    
    private func addTitleLabel() {
        tileView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: tileView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: tileView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: -4),
        ])
    }
    
    private func addScoreLabel() {
        tileView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: tileView.leadingAnchor, constant: 4),
            valueLabel.trailingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: -4),
            valueLabel.bottomAnchor.constraint(equalTo: tileView.bottomAnchor, constant: -4)
        ])
    }
    
    func configureBy(title: String, initialValue: Int) {
        titleLabel.text = title
        value = initialValue
    }
}
