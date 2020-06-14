//
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit
import FaceTracker

class FaceView: UIView {
    var facePoints: FacePoints?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func draw(_ rect: CGRect) {
        guard let leftEye = facePoints?.leftEye else { return }
        guard let rightEye = facePoints?.rightEye else { return }
        guard let nose = facePoints?.nose else { return }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setAlpha(0.4)
        context?.setFillColor(UIColor.black.cgColor)
        context?.setLineWidth(10)
        
        let leftEyeMinX = getMinX(leftEye)
        let centerX = leftEyeMinX + (getMaxX(rightEye) - leftEyeMinX) / 2
        let faceWidth = calcFaceWidth()
        let x =  centerX - faceWidth / 2
        let centerY = (getMaxY(leftEye) + getMaxY(nose)) / 2
        let faceHeight = calcFaceHeight()
        let y = centerY - faceHeight / 2
        context?.addEllipse(in: CGRect(x: x, y: y, width: faceWidth, height: faceHeight))
        context?.drawPath(using: .fill)
        
        transform = CGAffineTransform.identity
        setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
        
        let angle = calcAngleFrom(leftEye[0], to: rightEye[5])
        transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func calcFaceHeight() -> CGFloat {
        let u = (getMaxY(facePoints!.leftEye) - getMinY(facePoints!.leftBrow)) / 0.382
        let l = ((getMinY(facePoints!.innerMouth) + getMaxY(facePoints!.innerMouth) / 2) - getMaxY(facePoints!.nose)) / 0.618 -
        (getMinY(facePoints!.leftEye) + getMaxY(facePoints!.leftEye)) / 4
        return u+l
    }
    
    func calcFaceWidth() -> CGFloat {
        return (getMaxX(facePoints!.nose) - getMinX(facePoints!.nose)) / 0.279
    }
    
    func update(_ facePoints: FacePoints) {
        self.facePoints = facePoints
        self.setNeedsDisplay()
    }
}

