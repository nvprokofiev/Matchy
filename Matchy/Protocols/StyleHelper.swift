//
//  StyleHelper.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-06.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyTileStyle(colors: TwoColorsGradient = Gradients().randomColorSet()) {
        setGradientBackgroundColor(colors: colors)
        setCornerRadius()
        setShadow()
    }
    
    func setGradientBackgroundColor(colors: TwoColorsGradient) {
      layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = bounds
      gradientLayer.colors = [colors.from.cgColor, colors.to.cgColor]
      gradientLayer.locations = [0.0, 1.0]
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer.cornerRadius = bounds.height / 6
      layer.insertSublayer(gradientLayer, at: 0)
    }
    
    fileprivate func setCornerRadius(){
      layer.cornerRadius = bounds.height / 6
      layer.masksToBounds = true
      layer.borderWidth = 0.5
      layer.borderColor = UIColor.clear.cgColor
    }
    
    fileprivate func setShadow() {
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 1)
      layer.shadowOpacity = 0.2
      layer.shadowRadius = 1.0
      layer.masksToBounds = false
      layer.cornerRadius = 6.0
      clipsToBounds = false
    }
}

protocol StyleHelper {}

extension StyleHelper where Self: UIView {
  
  func setGradientBackgroundColor(to view: UIView, colors: TwoColorsGradient) {
    layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [colors.from.cgColor, colors.to.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.cornerRadius = view.bounds.height / 6
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func setCornerRadius(to view: UIView){
    view.layer.cornerRadius = view.bounds.height / 6
    view.layer.masksToBounds = true
    view.layer.borderWidth = 0.5
    view.layer.borderColor = UIColor.clear.cgColor
  }
  
  func setShadow(to view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 1)
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 1.0
    view.layer.masksToBounds = false
    view.layer.cornerRadius = 6.0
    view.clipsToBounds = false
  }
    
    func applyStyle(to view: UIView, colors: TwoColorsGradient = Gradients().randomColorSet()) {
        setGradientBackgroundColor(to: view, colors: colors)
        setCornerRadius(to: view)
        setShadow(to: view)
    }
}


