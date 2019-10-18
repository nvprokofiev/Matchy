//
//  Tile.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TileView: UIView, StyleHelper {

    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle(to: self)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        
    }
}
