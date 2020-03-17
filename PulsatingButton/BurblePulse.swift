//
//  BurblePulse.swift
//  PulsatingButton
//
//  Created by Julio Collado on 3/17/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit

class BurblePulse: CAShapeLayer {
    
    var animationGroup = CAAnimationGroup()
    
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Float = Float.infinity
    
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init (radius: CGFloat, position: CGPoint, numberOfPulses: Float? = Float.infinity) {
        super.init()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        self.path = circularPath.cgPath
        lineWidth = 2.0
        fillColor = UIColor.clear.cgColor
        lineCap = CAShapeLayerLineCap.round
        self.position = position
  
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
        
    }
    
    private func createScaleAnimation () -> CABasicAnimation {
        
        strokeColor = UIColor.black.cgColor
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = animationDuration
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        return scaleAnimation
    }
    
    private func createOpacityAnimation() -> CABasicAnimation {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        self.animationGroup.timingFunction = defaultCurve
        
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
        
    }
    
}
