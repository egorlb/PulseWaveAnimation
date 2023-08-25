//
//  PulseButton.swift
//  PulseWaveAnimation
//
//  Created by Egor Laba on 25.08.23.
//

import UIKit

final class PulseButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.height / 2
    }
    
    func createPulseAnimation() {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = bounds
        layer.addSublayer(replicatorLayer)
        
        let pulseLayer = createPulseLayer()
        
        replicatorLayer.addSublayer(pulseLayer)
        replicatorLayer.instanceCount = 2
        replicatorLayer.instanceDelay = 2.0 / TimeInterval(replicatorLayer.instanceCount)
        
        animatePulse(pulseLayer: pulseLayer, duration: 2.0, delay: 0.2, strokeColor: UIColor.white.withAlphaComponent(0.3).cgColor)
        animatePulse(pulseLayer: pulseLayer, duration: 2.0, delay: 0.4, strokeColor: UIColor.white.withAlphaComponent(0.3).cgColor)
    }
    
    private func createPulseLayer() -> CAShapeLayer {
        let pulseLayer = CAShapeLayer()
        let pulseRect = CGRect(x: -(frame.width / 2), y: -(frame.height / 2), width: frame.width, height: frame.height)
        pulseLayer.path = UIBezierPath(roundedRect: pulseRect, cornerRadius: frame.height).cgPath
        pulseLayer.lineWidth = 2.0
        pulseLayer.fillColor = UIColor.clear.cgColor
        pulseLayer.lineCap = .round
        pulseLayer.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
        return pulseLayer
    }
    
    private func animatePulse(pulseLayer: CAShapeLayer, duration: TimeInterval, delay: TimeInterval, strokeColor: CGColor) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.5
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        
        pulseLayer.add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        
        pulseLayer.add(opacityAnimation, forKey: "opacity")
        pulseLayer.strokeColor = strokeColor
    }
}

