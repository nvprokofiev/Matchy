//
//  CardIdentifierFactory.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct CardIdentifierFactory {
    private static var idFactory = 0
    static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    static func reset(){
        idFactory = 0
    }
}
