//
//  Router.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameRouter {
    enum Screen {
        case game
    }
    
    func route(to screen: Screen, from sourceViewController: UIViewController) {
        switch screen {
        case .game:
            let vc = GameViewController()
            sourceViewController.present(vc, animated: true, completion: nil)
        }
    }
}
