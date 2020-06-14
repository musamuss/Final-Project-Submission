//
//  NoseView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit
import FaceTracker

class NoseView: UIView {
    var nose: [CGPoint]?
    let noseView = UIImageView()
    var isNoseScaled = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        guard let nose = nose else { return }
        let noseMinX = getPointForMinX(nose)
        let noseSize = distanceFrom(noseMinX, to: getPointForMaxX(nose))
        let centerY = getMinY(nose)
        let noseMinY = centerY - noseSize / 2
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.red.cgColor)
        context?.addEllipse(in: CGRect(x: noseMinX.x * 0.95, y: noseMinY, width: noseSize * 1.1, height: noseSize * 1.1))

        context?.drawPath(using: .fill)
    }
    
    func scaleNose() {
        if (!isNoseScaled) {
            isNoseScaled = true
            transform = CGAffineTransform.identity
            setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
        
            transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        else {
            isNoseScaled = false
            transform = CGAffineTransform.identity
            setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
            
            transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        }
    }
    
    func update(_ nose: [CGPoint]) {
        self.nose = nose
        self.setNeedsDisplay()
    }
}

