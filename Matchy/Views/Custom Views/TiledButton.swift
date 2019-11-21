//
//  TiledButton.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-22.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TiledButton: UIButton {
    
    var title: String
    var action: ()->()
    
    init(title: String, action: @escaping ()->()){
        self.title = title
        self.action = action
    
        super.init(frame: .zero)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        self.title = "title"
        self.action = {}
        super.init(coder: coder)
        initialSetup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyTileStyle()
    }

    private func initialSetup() {
        titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.baselineAdjustment = .alignCenters
        
        setTitle(title, for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = .identity
        }, completion: {_ in
            self.action()
        })
    }
}
