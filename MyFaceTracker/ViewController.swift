//
//  ViewController.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit
import FaceTracker

class ViewController: UIViewController, FaceTrackerViewControllerDelegate {
    @IBOutlet weak var swapCameraButton: UIButton!
    @IBOutlet weak var makeSnapshotButton: UIButton!
    @IBOutlet weak var scaleNoseButton: UIButton!
    
    @IBOutlet weak var faceTrackerContainerView: UIView!
    weak var faceTrackerViewController: FaceTrackerViewController?
    
    var overlayViews = [String: [UIView]]()
    
    var leftEye: [CGPoint]?
    var rightEye: [CGPoint]?
    
    var mouth: MouthView?
    var brows: EyebrowView?
    var face: FaceView?
    var eyes: EyeView?
    var nose: NoseView?
    var hat: HatView?
    var moustache: MoustacheView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        face = FaceView(frame: self.view.bounds)
        self.view.insertSubview(face!, aboveSubview: faceTrackerContainerView)
        mouth = MouthView(frame: self.view.bounds)
        self.view.insertSubview(mouth!, aboveSubview: face!)
        brows = EyebrowView(frame: self.view.bounds)
        self.view.insertSubview(brows!, aboveSubview: face!)
        eyes = EyeView(frame: self.view.bounds)
        self.view.insertSubview(eyes!, aboveSubview: face!)
        nose = NoseView(frame: self.view.bounds)
        self.view.insertSubview(nose!, aboveSubview: face!)
        hat = HatView(frame: self.view.bounds)
        self.view.insertSubview(hat!, aboveSubview: brows!)
//        self.moustache = MoustacheView(frame: self.view.bounds)
//        self.view.insertSubview(moustache!, aboveSubview: face!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swapCameraButtonPressed(_ sender: UIButton) {
        faceTrackerViewController?.swapCamera()
    }
    
    @IBAction func MakeSnapshotButtonPressed(_ sender: UIButton) {
        makeSnapshot()
        flash()
    }
    
    @IBAction func scaleNoseButtonPressed(_ sender: UIButton) {
        nose?.scaleNose()
    }
    
    func flash() {
        if let wnd = self.view{
            
            let v = UIView(frame: wnd.bounds)
            v.backgroundColor = UIColor.white
            v.alpha = 1
            
            wnd.addSubview(v)
            UIView.animate(withDuration: 0.5, animations: {
                v.alpha = 0.0
            }, completion: {(finished:Bool) in
                v.removeFromSuperview()
            })
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "faceTrackerEmbed") {
            faceTrackerViewController = segue.destination as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        faceTrackerViewController!.startTracking { () -> Void in
            
        }
    }
    
    func updateViewForFeature(_ feature: String, index: Int, point: CGPoint, bgColor: UIColor) {
        
        let frame = CGRect(x: point.x-2, y: point.y-2, width: 4.0, height: 4.0)
        
        if self.overlayViews[feature] == nil {
            self.overlayViews[feature] = [UIView]()
        }
        
        if index < self.overlayViews[feature]!.count {
            self.overlayViews[feature]![index].frame = frame
            self.overlayViews[feature]![index].isHidden = false
            self.overlayViews[feature]![index].backgroundColor = bgColor
        } else {
            let newView = UIView(frame: frame)
            newView.backgroundColor = bgColor
            newView.isHidden = false
            self.view.addSubview(newView)
            self.overlayViews[feature]! += [newView]
        }
    }
    
    //        func hideAllOverlayViews() {
    //            for (_, views) in self.overlayViews {
    //                for view in views {
    //                    view.isHidden = true
    //                }
    //            }
    //        }
    
    func hideButtons() {
        swapCameraButton.isHidden = true
        makeSnapshotButton.isHidden = true
    }
    
    func showButtons() {
        swapCameraButton.isHidden = false
        makeSnapshotButton.isHidden = false
    }
    
    func makeSnapshot() {
        hideButtons()
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = CGInterpolationQuality.high
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(viewImage!, nil, nil, nil);
        showButtons()
    }
    
    func faceTrackerDidUpdate(_ points: FacePoints?) {
        if let points = points {
            displayAllOverlayViews()
            //            update(leftEye: points.leftEye, rightEye: points.rightEye)
            //            draw(leftEye: points.leftEye, rightEye: points.rightEye)
            face!.update(points)
            eyes!.update(leftEye: points.leftEye, rightEye: points.rightEye)
            mouth!.update(innerMouth: points.innerMouth, outerMouth: points.outerMouth)
            //                brows!.update(points.leftBrow, rightBrow: points.rightBrow)
            eyes!.update(leftEye: points.leftEye, rightEye: points.rightEye)
            nose!.update(points.nose)
            hat!.update(leftEye: points.leftEye, rightEye: points.rightEye)
            
//            moustache!.update(innerMouth: points.innerMouth, outerMouth: points.outerMouth)
            
            
            // commented out the displaying of the points
//            for (index, point) in points.leftEye.enumerated() {
//                self.updateViewForFeature("leftEye", index: index, point: point, bgColor: UIColor.blue)
//            }
//            
//            for (index, point) in points.rightEye.enumerated() {
//                self.updateViewForFeature("rightEye", index: index, point: point, bgColor: UIColor.blue)
//            }
//            
//            for (index, point) in points.leftBrow.enumerated() {
//                self.updateViewForFeature("leftBrow", index: index, point: point, bgColor: UIColor.white)
//            }
//            
//            for (index, point) in points.rightBrow.enumerated()
//            {
//                self.updateViewForFeature("rightBrow", index: index, point: point, bgColor: UIColor.white)
//            }
//            
//            for (index, point) in points.nose.enumerated() {
//                self.updateViewForFeature("nose", index: index, point: point, bgColor: UIColor.purple)
//            }
//            
//            for (index, point) in points.innerMouth.enumerated() {
//                self.updateViewForFeature("innerMouth", index: index, point: point, bgColor: UIColor.red)
//            }
//            
//            for (index, point) in points.outerMouth.enumerated(){
//                self.updateViewForFeature("outerMouth", index: index, point: point, bgColor: UIColor.yellow)
//            }
            
        }
        else {
            self.hideAllOverlayViews()
        }
    }
    
    func displayAllOverlayViews() {
        mouth!.isHidden = false
        brows!.isHidden = false
        face!.isHidden = false
        eyes!.isHidden = false
        nose!.isHidden = false
        hat!.isHidden = false
//        moustache!.isHidden = false
    }
    
    func hideAllOverlayViews() {
        mouth!.isHidden = true
        brows!.isHidden = true
        face!.isHidden = true
        eyes!.isHidden = true
        nose!.isHidden = true
        hat!.isHidden = true
//        moustache!.isHidden = true
        
        for (_, views) in self.overlayViews {
            for view in views {
                view.isHidden = true
            }
        }
    }
    
    func draw(_ rect: CGRect) {
        guard let leftEye = leftEye else { return }
        guard let rightEye = rightEye else { return }
        
        drawEye(leftEye, "leftEye")
        drawEye(rightEye, "rightEye")
    }
    
    func drawEye(_ points: [CGPoint], _ feature: String) {
        let eyeHeight = distanceFrom(points[2], to: points[8])
        let eyeCenter = CGPoint(x: (points[0].x + points[5].x) / 2, y: (points[0].y + points[5].y) / 2)
        let irisWidth = eyeHeight
        
        // Draw Iris
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.green.cgColor)
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
        //        self.setNeedsDisplay()
    }
    
}

