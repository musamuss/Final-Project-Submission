//
//  Util.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import CoreImage

func getMaxY(_ points: [CGPoint]) -> CGFloat {
    return points.reduce(0, { (y:CGFloat, p: CGPoint) -> CGFloat in y > p.y ? y : p.y })
}

func getMinY(_ points: [CGPoint]) -> CGFloat {
    return points.reduce(10000, { (y:CGFloat, p: CGPoint) -> CGFloat in y < p.y ? y : p.y })
}

func getMaxX(_ points: [CGPoint]) -> CGFloat {
    return points.reduce(0, { (x:CGFloat, p: CGPoint) -> CGFloat in x > p.x ? x : p.x })
}

func getMinX(_ points: [CGPoint]) -> CGFloat {
    return points.reduce(10000, { (x:CGFloat, p: CGPoint) -> CGFloat in x < p.x ? x : p.x })
}

func getPointForMaxY(_ points: [CGPoint]) -> CGPoint {
    return points.reduce(CGPoint(x:0, y:0), { (pMax:CGPoint, p: CGPoint) -> CGPoint in pMax.y > p.y ? pMax : p })
}

func getPointForMinY(_ points: [CGPoint]) -> CGPoint {
    return points.reduce(CGPoint(x:10000, y:10000), { (pMin:CGPoint, p: CGPoint) -> CGPoint in pMin.y < p.y ? pMin : p })
}

func getPointForMaxX(_ points: [CGPoint]) -> CGPoint {
    return points.reduce(CGPoint(x: 0, y: 0), { (pMax:CGPoint, p: CGPoint) -> CGPoint in pMax.x > p.x ? pMax : p })
}

func getPointForMinX(_ points: [CGPoint]) -> CGPoint {
    return points.reduce(CGPoint(x: 10000,y: 10000), { (pMin:CGPoint, p: CGPoint) -> CGPoint in pMin.x < p.x ? pMin : p })
}

func calcAngleFrom(_ p1: CGPoint, to p2: CGPoint) -> CGFloat {
    return atan2(p2.y - p1.y, p2.x - p1.x)
}

func distanceFrom(_ p1: CGPoint, to p2: CGPoint) -> CGFloat {
    return sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
}
