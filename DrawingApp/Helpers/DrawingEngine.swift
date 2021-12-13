//
//  DrawingEngine.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import Foundation
import SwiftUI

class DrawingEngine {
    
    func createPath(for points: [CGPoint]) -> Path {
        var path = Path()
        if points.count < 2 { return path }
        if let firstPoint = points.first {
            path.move(to: firstPoint)
        }
        for index in 1..<points.count {
            let mid = calculateMidPoint(points[index - 1], points[index])
            path.addQuadCurve(to: mid, control: points[index - 1])
        }
        if let last = points.last {
            path.addLine(to: last)
        }
        return path
    }
    
    func calculateMidPoint(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        let newMidPoint = CGPoint(x: (point1.x + point2.x)/2, y: (point1.y + point2.y)/2)
        return newMidPoint
    }
}

