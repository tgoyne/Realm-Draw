//
//  Line.swift
//  DrawingApp
//
//  Created by Andrew Morgan on 18/11/2021.
//

import Foundation
import SwiftUI
import RealmSwift

class Line: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var lineColor: PersistableColor?
    @Persisted var lineWidth = 5.0
    @Persisted var linePoints = RealmSwift.List<PersistablePoint>()
    
}

extension Line {
    var points: [CGPoint] {
        linePoints.map { point in
            point.point
        }
    }
    
    var color: Color {
        get {
            lineColor?.color ?? .black
        }
        set {
            lineColor = PersistableColor(color: newValue)
        }
    }
    
    var width: CGFloat {
        get {
            CGFloat(lineWidth)
        }
        set {
            lineWidth = Double(newValue)
        }
    }
    
    convenience init (point: PersistablePoint, color: Color, lineWidth: CGFloat) {
        self.init()
        self.linePoints.append(point)
        self.color = color
        self.width = lineWidth
    }
    
    convenience init (points: [CGPoint], color: Color, lineWidth: CGFloat, xScale: CGFloat, yScale: CGFloat) {
        self.init()
        let persistablePoints = RealmSwift.List<PersistablePoint>()
        points.forEach() { point in
            persistablePoints.append(PersistablePoint(x: point.x / xScale, y: point.y / yScale))
        }
        self.linePoints = persistablePoints
        self.color = color
        self.width = lineWidth
    }
}
