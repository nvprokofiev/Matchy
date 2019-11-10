//
//  GameLevel.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct GameLevel {
    
    private let incrementor = 2
    private let failureIncrementor = 1
    
    private(set) var level = 1
    private(set) var value = 2

    mutating func levelUp(){
        var newValue = value + incrementor
        level += 1

        func getNewValue(from value: Int)-> Int {
            let rows = floor(sqrt(Double(value)))
            let columns = (Double(value)/rows)

            if columns.truncatingRemainder(dividingBy: 1) == 0 {
                return newValue
            } else {
                newValue = newValue + failureIncrementor
                return getNewValue(from: newValue)
            }
        }
        value = getNewValue(from: value)
    }
    
    mutating func reset() {
        level = 1
        value = 2
    }
}
