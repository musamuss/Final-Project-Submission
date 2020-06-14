//
//  EyeView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit

class EyeView: UIView {
    var leftEye: [CGPoint]?
    var rightEye: [CGPoint]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        guard let leftEye = leftEye else { return }
        guard let rightEye = rightEye else { return }
        
        drawEye(leftEye)
        drawEye(rightEye)
    }

    func drawEye(_ points: [CGPoint]) {
        let eyeHeight = distanceFrom(points[2], to: points[8])
        let eyeCenter = CGPoint(x: (points[0].x + points[5].x) / 2, y: (points[0].y + points[5].y) / 2)
        let irisWidth = eyeHeight
        
        // Draw Iris
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.blue.cgColor)
        let iPath = CGMutablePath()
    
        iPath.addArc(center: CGPoint(x: eyeCenter.x, y: eyeCenter.y),
                    radius: irisWidth/2,
                    startAngle: calcAngleFrom(eyeCenter, to: points[3]),
                    endAngle: calcAngleFrom(eyeCenter, to: points[7]),
                    clockwise: true)
        
        iPath.addArc(center: CGPoint(x: eyeCenter.x, y: eyeCenter.y),
                     radius: irisWidth/2,
                     startAngle: calcAngleFrom(eyeCenter, to: points[8]),
                     endAngle: calcAngleFrom(eyeCenter, to: points[2]),
                     clockwise: true)
        
        iPath.closeSubpath()
        context?.addPath(iPath)
        context?.drawPath(using: .fill)
        
        // Draw pupil
        let pupilWidth = irisWidth * 0.4
        context?.setFillColor(UIColor.black.cgColor)
        context?.addEllipse(in: CGRect(x: eyeCenter.x - pupilWidth/2, y: eyeCenter.y - pupilWidth/2, width: pupilWidth, height: pupilWidth))
        context?.drawPath(using: .fill)

        // Draw eye outline
        let path = CGMutablePath()
        for (index, point) in points.enumerated() {
            if(index == 0) {
                path.move(to: CGPoint(x: point.x, y: point.y))
//                CGPathMoveToPoint(path, nil, point.x, point.y);
            }
            else {
//                CGPathAddLineToPoint(path, nil, point.x, point.y);
                path.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        }
        path.closeSubpath()
        context?.addPath(path)
        context?.setLineWidth(2.0)
        context?.drawPath(using: .stroke)
    }
    
    func update(leftEye: [CGPoint], rightEye: [CGPoint]) {
        self.leftEye = leftEye
        self.rightEye = rightEye
        self.setNeedsDisplay()
    }
}

