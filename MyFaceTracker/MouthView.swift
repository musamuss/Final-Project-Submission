//
//  MouthView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit

class MouthView: UIView {
    var innerMouth: [CGPoint]?
    var outerMouth: [CGPoint]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        let color:UIColor = UIColor.red
        
        color.set()
        
        if let points = outerMouth {
            let path = CGMutablePath()
            for (index, point) in points.enumerated() {
                if(index == 0) {
                    path.move(to: CGPoint(x: point.x, y: point.y))
//                    CGPathMoveToPoint(path, nil, point.x, point.y);
                }
                else {
//                    CGPathAddLineToPoint(path, nil, point.x, point.y);
                    path.addLine(to: CGPoint(x: point.x, y: point.y));
                }
            }
            path.closeSubpath()
            let x = UIBezierPath(cgPath: path)
            x.fill()
            
            let iPath = CGMutablePath()
            if let points = innerMouth {
                for (index, point) in points.enumerated() {
                    if(index == 0) {
                        path.move(to: CGPoint(x: point.x, y: point.y))

//                        CGPathMoveToPoint(iPath, nil, point.x, point.y);
                    }
                    else {
//                        CGPathAddLineToPoint(iPath, nil, point.x, point.y);
                        iPath.addLine(to: CGPoint(x: point.x, y: point.y))

                    }
                }
            }
            iPath.closeSubpath()
            let y = UIBezierPath(cgPath: iPath)
            let color2 = UIColor.black
            color2.set()
            y.fill()
            
        }
    }
    
    func update(innerMouth: [CGPoint], outerMouth: [CGPoint]) {
        self.innerMouth = innerMouth
        self.outerMouth = outerMouth
        self.setNeedsDisplay()
    }
}

