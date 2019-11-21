//
//  FlipAnimationConstants.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-11-19.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct FlipAnimationConstants {
    
    static let duration: TimeInterval = 0.5
    static let delay: TimeInterval = 0.55
    static let pause: TimeInterval = 0.25
    static var hideDuration: TimeInterval {
        return duration * 2 + delay + pause
    }
}
