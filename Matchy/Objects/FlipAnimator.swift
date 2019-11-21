//
//  FlipAnimator.swift
//  Matchy
//
//  Created by Nikolai Prokofev on 2019-10-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

struct FlipAnimator {
    
    func open(_ view: UIView, duration: TimeInterval = FlipAnimationConstants.duration, pause: TimeInterval = FlipAnimationConstants.pause, onHalfComplete: (()->())? = nil, onComplete: (()->())? = nil) {
        
        animate(view, wirh: .open, duration: duration, onHalfComplete: {
            onHalfComplete?()
        }, onComplete: {
            DispatchQueue.main.asyncAfter(deadline: .now() + pause, execute: {
                onComplete?()
            })
        })
    }
    
    func close(_ view: UIView, duration: TimeInterval = FlipAnimationConstants.duration, onHalfComplete: (()->())? = nil, onComplete: (()->())? = nil) {
        
        animate(view, wirh: .close, duration: duration, onHalfComplete: {
            onHalfComplete?()
        }, onComplete: {
            onComplete?()
        })
    }
    
    func show(_ view: UIView, duration: TimeInterval = FlipAnimationConstants.duration, pause: TimeInterval = FlipAnimationConstants.pause, onHalfComplete: (()->())? = nil, onComplete: (()->())? = nil) {
        
        self.open(view, onHalfComplete: {
            onHalfComplete?()
        }, onComplete: {
            self.close(view, onHalfComplete: {
                onComplete?()
            })
        })
    }
    
    func hide(_ view: UIView, duration: TimeInterval = FlipAnimationConstants.duration, onComplete: (()->())? = nil) {
        
        UIView.animate(withDuration: duration / 2, animations: {
            view.layer.transform = FlipTransformType.close.halfCycleTransform
        }, completion: {_ in
            onComplete?()
        })
    }
    
    func showHide(_ view: UIView, duration: TimeInterval = FlipAnimationConstants.duration, pause: TimeInterval = FlipAnimationConstants.pause, delay: TimeInterval = FlipAnimationConstants.delay, onHalfComplete: (()->())? = nil, onComplete: (()->())? = nil) {

        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.open(view, onHalfComplete: {
                onHalfComplete?()
            }, onComplete: {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + pause, execute: {
                    self.hide(view, onComplete: {
                        onComplete?()
                    })
                })
            })
        })
    }

    private func animate(_ view: UIView,
                         wirh transform: FlipTransformType,
                         duration: TimeInterval,
                         onHalfComplete:(()->())?,
                         onComplete: (()->())?){
    
        UIView.animate(withDuration: duration / 2, delay: 0.0, options: [.curveEaseIn], animations: {
                view.layer.transform = FlipTransformType.hide.halfCycleTransform
            }, completion: {_ in
                onHalfComplete?()
                
                UIView.animate(withDuration: duration / 2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
                    view.layer.transform = transform.endCycleTransform
                }, completion: {_ in
                    onComplete?()
                })
            })
    }
}

enum FlipTransformType {
    case open, close, hide
    
    private var transform: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000
        return transform
    }
    
    fileprivate var halfCycleTransform: CATransform3D {
        return CATransform3DRotate(transform, .pi/2, 0.0, 1.0, 0.0)
    }
    
    fileprivate var endCycleTransform: CATransform3D {
        switch self {
        case .open:
            return CATransform3DRotate(transform, .pi, 0.0, 1.0, 0.0)
        case .close:
            return CATransform3DIdentity
        default:
            return CATransform3DIdentity
        }
    }
}
