//
//  LoadingAnimation.swift
//  tg
//
//  Created by Apple on 9.12.21.
//

import UIKit

class LoadingAnimation: UIView {
   
    override func draw(_ rect: CGRect) {
        drawView()
        animateView()
    }
    func drawView() {
        let circle = UIBezierPath()
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        circle.addArc(withCenter: center, radius: self.bounds.width / 2 - 5, startAngle: 0, endAngle: CGFloat.pi * 1.5, clockwise: true)
        circle.lineWidth = 3
        UIColor.gray.setStroke()
        circle.stroke()
    }
    func animateView() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.repeatCount = .infinity
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 2.0
        rotation.isRemovedOnCompletion = false
        self.layer.add(rotation, forKey: "customRotation")
    }
    func animationStop() {
        layer.speed = 0.0
    }
    func animationResume() {
        layer.speed = 1.0
    }
}
