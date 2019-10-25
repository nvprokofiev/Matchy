//
//  TiledButton.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-22.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TiledButton: UIButton, StyleHelper {
    
    var title: String
    var action: ()->()
    
    init(title: String, action: @escaping ()->()){
        self.title = title
        self.action = action
        
        super.init(frame: .zero)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyStyle(to: self)
    }

    private func initialSetup() {
        titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.baselineAdjustment = .alignCenters
        
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(callback), for: .touchUpInside)
    }
    
    @objc private func callback() -> Void {
        action()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
}
