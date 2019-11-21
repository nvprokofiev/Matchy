//
//  TextTileView.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-11-20.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TextTileView: UIView {
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String = String() {
        didSet {
            subtitleLabel.text = subtitle
            titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 0.2
        label.font = UIFont.systemFont(ofSize: 56, weight: .semibold)
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
        addStackView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyTileStyle()
    }

    private func addStackView() {
        
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(titleLabel)

        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func setFont(_ font: UIFont) {
        titleLabel.font = font
    }
}
