//
//  GameSessionConfiguration.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation


struct GameConfiguration {
    
}

struct GameLevel {
    
    var level = 1
    private let incrementor = 2
    
    mutating func levelUp() {
        level += 1
    }
    
    var pairsNumber: Int {
        return level * incrementor
    }
}
