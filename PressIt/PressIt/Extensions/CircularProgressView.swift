//
//  CircularProgressView.swift
//  PressIt
//
//  Created by Roe Iton on 20/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class CircularProgressView: UIView {
   var progressLyr = CAShapeLayer()
   var trackLyr = CAShapeLayer()
    var currentValue: Float;
    
   required init?(coder aDecoder: NSCoder) {
       self.currentValue = 0;
      super.init(coder: aDecoder)
      makeCircularPath()
   }
   var progressClr = UIColor.white {
      didSet {
         progressLyr.strokeColor = progressClr.cgColor
      }
   }
   var trackClr = UIColor.init(red: 184, green: 244, blue: 199, alpha: 1) {
      didSet {
         trackLyr.strokeColor = trackClr.cgColor
      }
   }
   func makeCircularPath() {
      self.backgroundColor = UIColor.clear
      self.layer.cornerRadius = self.frame.size.width/2
      let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
      trackLyr.path = circlePath.cgPath
      trackLyr.fillColor = UIColor.clear.cgColor
      trackLyr.strokeColor = trackClr.cgColor
      trackLyr.lineWidth = 5.0
      trackLyr.strokeEnd = 1.0
      layer.addSublayer(trackLyr)
      progressLyr.path = circlePath.cgPath
      progressLyr.fillColor = UIColor.clear.cgColor
      progressLyr.strokeColor = progressClr.cgColor
      progressLyr.lineWidth = 10.0
      progressLyr.strokeEnd = 0.0
      layer.addSublayer(progressLyr)
   }
    
   func setProgressWithAnimation(duration: TimeInterval, value: Float) {
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.duration = duration
      animation.fromValue = 0
      animation.toValue = value
      animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
      progressLyr.strokeEnd = CGFloat(value)
      progressLyr.add(animation, forKey: "animateprogress")

      currentValue = value;
   }
    
    func setProgressWithOutAnimation(value: Float) {
       let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0;
       animation.fromValue = currentValue
       animation.toValue = value
       animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
       progressLyr.strokeEnd = CGFloat(value)
       progressLyr.add(animation, forKey: "animateprogress")
        
       currentValue = value;
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 1.0
        pulse.toValue = 1.08
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.1
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
