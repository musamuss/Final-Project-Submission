//
//  MoustacheView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 17.09.17.
//  Copyright © 2017 camtasia. All rights reserved.
//

//
//  MouthView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit

class MoustacheView: UIView {
    var innerMouth: [CGPoint]?
    var outerMouth: [CGPoint]?
    let moustacheView = UIImageView()
    let beardEnd    = 8
    let beardStart  = 11
    
    override init(frame: CGRect) {
        moustacheView.image = UIImage(named: "imperial_moustache.png")
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(moustacheView)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        let cornerDistance :CGFloat
        var filterCenter :CGPoint
        let filterAngle :CGFloat
        var size = CGSize()
        guard let outerMouth = outerMouth else { return }
        
        cornerDistance = sqrt(pow(outerMouth[0].x - outerMouth[6].x, 2) + pow(outerMouth[0].y - outerMouth[6].y, 2))
        filterCenter = CGPoint(x: (outerMouth[0].x + outerMouth[6].x) / 2, y: (outerMouth[0].y + outerMouth[6].y) / 2)
        filterAngle = atan2(outerMouth[6].y - outerMouth[0].y, outerMouth[6].x - outerMouth[0].x)

        size.width = 1.5 * cornerDistance;
        size.height = (moustacheView.image!.size.height / moustacheView.image!.size.width) * size.width;
        filterCenter.x = filterCenter.x - (size.width / 2);
        filterCenter.y = filterCenter.y - 0.8 * size.height;
        
        moustacheView.isHidden = false
        
        moustacheView.setAnchorPoint(CGPoint(x: filterCenter.x, y: filterCenter.y));
       
        moustacheView.transform = CGAffineTransform(rotationAngle: filterAngle);
        
        // Beard Work start
        // beardCenter = 3 ; beardEnd    = 8; beardStart  = 11
        
//        guard let outerMouth = outerMouth else { return }
//    
//        let beardDiameter = ( sqrt(
//            pow(outerMouth[beardEnd].x - outerMouth[beardStart].x, 2) +
//                pow(outerMouth[beardEnd].y - outerMouth[beardStart].y, 2) ) )
//        
//        moustacheView.transform = CGAffineTransform.identity
//        moustacheView.frame = CGRect(
//            x: outerMouth[beardStart].x,
//            y: outerMouth[beardStart].y,
//            width:  beardDiameter,
//            height: beardDiameter * 0.40
//        )
//        
//        moustacheView.isHidden = false
//        moustacheView.setAnchorPoint(CGPoint(x: 0.5, y: 0.9));
//        moustacheView.transform = CGAffineTransform(rotationAngle: filterAngle);
    
    
    }
    
    func update(innerMouth: [CGPoint], outerMouth: [CGPoint]) {
        self.innerMouth = innerMouth
        self.outerMouth = outerMouth
        self.setNeedsDisplay()
    }
}


