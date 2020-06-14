//
//  EyebrowView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit

class EyebrowView: UIView {
    var leftBrow: [CGPoint]?
    var rightBrow: [CGPoint]?
    
    let browPattern: UIImage?
    
    override init(frame: CGRect) {
        browPattern = UIImage(named: "BrowPattern.png")
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        browPattern = UIImage(named: "BrowPattern.png")
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        guard let leftBrow = leftBrow else { return }
        guard let rightBrow = rightBrow else { return }
        
        drawBrow(leftBrow)
        drawBrow(rightBrow)
        }
    

    func drawBrow(_ points: [CGPoint]) {
        var color = UIColor.brown
        if let browPattern = browPattern {
            color = UIColor(patternImage: browPattern)
        }
        
        let path:CGMutablePath = CGMutablePath()
        var startPoint: CGPoint?
        for (index, point) in points.enumerated() {
            if(index == 0) {
                startPoint = point
                path.move(to: CGPoint(x: point.x, y: point.y))
//                CGPathMoveToPoint(path, nil, point.x, point.y);
            }
            else {
//                CGPathAddLineToPoint(path, nil, point.x as CGFloat, point.y as CGFloat);
                path.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        }
//        CGPathAddLineToPoint(path, nil, startPoint!.x as CGFloat, startPoint!.y as CGFloat)
        path.addLine(to: CGPoint(x: startPoint!.x, y: startPoint!.y))
        path.closeSubpath()
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(path)
        context?.setFillColor(color.cgColor)
        context?.drawPath(using: .fill)
    }
    
    func update(_ leftBrow: [CGPoint], rightBrow: [CGPoint]) {
        self.leftBrow = leftBrow
        self.rightBrow = rightBrow
        self.setNeedsDisplay()
    }
}

