//
//  AnimationExtention.swift
//  TayarIndicator
//
//  Created by SeMbA on 7/16/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import UIKit
import QuartzCore

extension UIView {
    
    func driveAnimation() {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = (self.frame.origin.y + self.bounds.height/2) + 0.5
        animation.toValue = (self.frame.origin.y + self.bounds.height/2) - 0.5
        animation.isRemovedOnCompletion = false
        animation.duration = 0.25
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        self.layer.add(animation, forKey: "shake")
    }
    
    func enteranceAnimation() {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = 0
        animation.toValue = self.frame.origin.x + self.bounds.width/2
        animation.isRemovedOnCompletion = true
        animation.duration = 1
        self.layer.add(animation, forKey: "driveAnimation")
    }
    
    func exitAnimation()
    {
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = self.frame.origin.x + self.bounds.width/2
        animation.toValue = UIScreen.main.bounds.width // + (self.bounds.width/2)
        animation.isRemovedOnCompletion = true
        animation.duration = 1
        CATransaction.setCompletionBlock {
            self.alpha = 0
        }
        self.layer.add(animation, forKey: "exitAnimation")
        CATransaction.commit()
    }
    
    func wheelieAnimation()
    {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = CGFloat(-0.7)
        animation.isRemovedOnCompletion = true
        animation.duration = 0.7
        animation.autoreverses = true
        self.layer.add(animation, forKey: "wheelieAnimation")
    }
    
    func bikeEnteranceAnimation()
    {
        self.alpha = 0
        self.driveAnimation()
        self.wheelieAnimation()
        
        let now = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: now + 0.35) {
            self.enteranceAnimation()
            self.alpha = 1
        }
    }
    
    func bikeExitAnimation()
    {
        self.wheelieAnimation()
        self.exitAnimation()
    }
}

