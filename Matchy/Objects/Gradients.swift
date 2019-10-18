//
//  Gradients.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

typealias TwoColorsGradient = (from: UIColor, to: UIColor)

struct Gradients {
    
    private let red = [#colorLiteral(red: 0.9654200673, green: 0.1590853035, blue: 0.2688751221, alpha: 1),#colorLiteral(red: 0.7559037805, green: 0.1139892414, blue: 0.1577021778, alpha: 1)]
    private let orangeRed = [#colorLiteral(red: 0.9338900447, green: 0.4315618277, blue: 0.2564975619, alpha: 1),#colorLiteral(red: 0.8518816233, green: 0.1738803983, blue: 0.01849062555, alpha: 1)]
    private let orange = [#colorLiteral(red: 0.9953531623, green: 0.54947716, blue: 0.1281470656, alpha: 1),#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1)]
    private let yellow = [#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1),#colorLiteral(red: 0.8931249976, green: 0.5340107679, blue: 0.08877573162, alpha: 1)]
    private let green = [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2060100436, green: 0.6006633639, blue: 0.09944178909, alpha: 1)]
    private let greenBlue = [#colorLiteral(red: 0.2761503458, green: 0.824685812, blue: 0.7065336704, alpha: 1),#colorLiteral(red: 0, green: 0.6422213912, blue: 0.568986237, alpha: 1)]
    private let kindaBlue = [#colorLiteral(red: 0.2494148612, green: 0.8105323911, blue: 0.8425348401, alpha: 1),#colorLiteral(red: 0, green: 0.6073564887, blue: 0.7661359906, alpha: 1)]
    private let skyBlue = [#colorLiteral(red: 0.3045541644, green: 0.6749247313, blue: 0.9517192245, alpha: 1),#colorLiteral(red: 0.008423916064, green: 0.4699558616, blue: 0.882807076, alpha: 1)]
    private let blue = [#colorLiteral(red: 0.1774400771, green: 0.466574192, blue: 0.8732826114, alpha: 1),#colorLiteral(red: 0.00491155684, green: 0.287129879, blue: 0.7411141396, alpha: 1)]
    private let bluePurple = [#colorLiteral(red: 0.4613699913, green: 0.3118675947, blue: 0.8906354308, alpha: 1),#colorLiteral(red: 0.3018293083, green: 0.1458326578, blue: 0.7334778905, alpha: 1)]
    private let purple = [#colorLiteral(red: 0.7080290914, green: 0.3073516488, blue: 0.8653779626, alpha: 1),#colorLiteral(red: 0.5031493902, green: 0.1100070402, blue: 0.6790940762, alpha: 1)]
    private let pink = [#colorLiteral(red: 0.95, green: 0.285, blue: 0.3904959302, alpha: 1),#colorLiteral(red: 0.8123683333, green: 0.1657164991, blue: 0.5003474355, alpha: 1)]
    private let dopelyColor1 = [UIColor(rgb: 0x222830), UIColor(rgb: 0x222830)]
    private let dopelyColor2 = [UIColor(rgb: 0xb0b5b5), UIColor(rgb: 0xb0b5b5)]
    private let dopelyColor3 = [UIColor(rgb: 0xecbd8b), UIColor(rgb: 0xecbd8b)]
    private let dopelyColor4 = [UIColor(rgb: 0xf4841a), UIColor(rgb: 0xf4841a)]
    private let dopelyColor5 = [UIColor(rgb: 0x004c56), UIColor(rgb: 0x004c56)]
    
    private let gray = [UIColor(rgb: 0xE5E5E5), UIColor(rgb: 0xE5E5E5)]

    func randomColorSet() -> TwoColorsGradient {
        
        let colors = Set([red, orangeRed, orange, yellow, green, greenBlue, kindaBlue, skyBlue, blue, bluePurple, purple, pink, dopelyColor1, dopelyColor2, dopelyColor3, dopelyColor4, dopelyColor5])

        guard let randomColors = colors.randomElement() else {
            return (gray[0], gray[1])
        }

        return (randomColors[0], randomColors[1])
    }
    
    func defaultColorSet() -> TwoColorsGradient {
        return (gray[0], gray[1])
    }
    
    func getSet(of total: Int) -> [TwoColorsGradient] {
        let delta = 255 / total
        let colors: [TwoColorsGradient] = (1 ... total).map {
            
            let r = CGFloat(delta *  $0)
            print(r)
            let fc = UIColor(red: r / 255, green: r / 255, blue: 1, alpha: 1)
            return (fc, fc)
        }
        return colors
    }
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
