//
//  GallowsView.swift
//  HMan
//
//  Created by James Steimel on 11/30/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

//MARK - Global Functions

func connectPoints(bottomLeftPoint: CGPoint, bottomRightPoint: CGPoint, topLeftPoint: CGPoint, topRightPoint: CGPoint, color: UIColor) {
    color.set()
    
    let path = UIBezierPath()
    path.move(to: bottomLeftPoint)
    path.addLine(to: topLeftPoint)
    path.addLine(to: topRightPoint)
    path.addLine(to: bottomRightPoint)
    path.close()
    path.fill()
    path.stroke()
}

func calculateMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
    return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
}

class GallowsView: UIView {
    
    //MARK - Drawing Scales and Constants
    
    struct DrawingConstants {
        static let gallowBaseStartScale: CGFloat = 0.15
        static let gallowBaseEndScale: CGFloat = 0.85
        static let gallowBaseHeight: CGFloat = 10
        static let gallowHeight: CGFloat = 0.05        //static let gallowHeight: CGFloat = 0.15
        static let gallowHeightStart: CGFloat = 0.175
        static let gallowHeightWidth: CGFloat = 10
        static let gallowAcrossScale: CGFloat = 0.5
        static let gallowTipHeight: CGFloat = 17.5
        static let headRadius: CGFloat = 16
        static let bodyLength: CGFloat = 25
        static let bodyHeight: CGFloat = 25
        static let legLength: CGFloat = 50
        static let grassHeightScale: CGFloat = 0.68
        static let armBack: CGFloat = 5
    }
    
    //MARK - Drawing Functions
    
    override func draw(_ rect: CGRect) {
        drawGrass()
        drawSky()
        drawGallow()
    }
    
    func drawGrass() {
        let topStartPoint = CGPoint(x: CGFloat(0), y: CGFloat(bounds.size.height * DrawingConstants.grassHeightScale))
        let topRightPoint = CGPoint(x: CGFloat(bounds.size.width), y: topStartPoint.y)
        let bottomRightPoint = CGPoint(x: topRightPoint.x, y: CGFloat(bounds.size.height))
        let bottomLeftPoint = CGPoint(x: CGFloat(0), y: bottomRightPoint.y)
        
        connectPoints(bottomLeftPoint: bottomLeftPoint, bottomRightPoint: bottomRightPoint, topLeftPoint: topStartPoint, topRightPoint: topRightPoint, color: UIColor.green)
    }
    
    func drawSky() {
        let bottomLeftPoint = CGPoint(x: CGFloat(0), y: CGFloat(bounds.size.height * DrawingConstants.grassHeightScale))
        let topLeftPoint = CGPoint(x: CGFloat(0), y: CGFloat(0))
        let topRightPoint = CGPoint(x: CGFloat(bounds.size.width), y: CGFloat(0))
        let bottomRightPoint = CGPoint(x: CGFloat(bounds.size.width), y: CGFloat(bounds.size.height * DrawingConstants.grassHeightScale))
        
        connectPoints(bottomLeftPoint: bottomLeftPoint, bottomRightPoint: bottomRightPoint, topLeftPoint: topLeftPoint, topRightPoint: topRightPoint, color: UIColor.cyan)
    }
    
    func drawGallow() {
        drawGallowBase()
        drawGallowHeight()
        drawGallowAcross()
        drawGallowTip()
    }
    
    func drawGallowBase() {
        let bottomLeftPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowBaseStartScale), y: CGFloat(bounds.size.height * DrawingConstants.grassHeightScale))
        let topLeftPoint = CGPoint(x: bottomLeftPoint.x, y: bottomLeftPoint.y - DrawingConstants.gallowBaseHeight)
        let topRightPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowBaseEndScale), y: topLeftPoint.y)
        let bottomRightPoint = CGPoint(x: topRightPoint.x, y: bottomLeftPoint.y)
        
        connectPoints(bottomLeftPoint: bottomLeftPoint, bottomRightPoint: bottomRightPoint, topLeftPoint: topLeftPoint, topRightPoint: topRightPoint, color: UIColor.brown)
    }
    
    func drawGallowHeight() {
        let bottomLeftPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowHeightStart), y: CGFloat(bounds.size.height * DrawingConstants.grassHeightScale - DrawingConstants.gallowBaseHeight))
        let bottomRightPoint = CGPoint(x: bottomLeftPoint.x + DrawingConstants.gallowHeightWidth, y: bottomLeftPoint.y)
        let topLeftPoint = CGPoint(x: bottomLeftPoint.x, y: bounds.size.height * DrawingConstants.gallowHeight)
        let topRightPoint = CGPoint(x: bottomRightPoint.x, y: topLeftPoint.y)
        
        connectPoints(bottomLeftPoint: bottomLeftPoint, bottomRightPoint: bottomRightPoint, topLeftPoint: topLeftPoint, topRightPoint: topRightPoint, color: UIColor.brown)
    }
    
    func drawGallowAcross() {
        let bottomLeftPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowHeightStart) + DrawingConstants.gallowHeightWidth, y: CGFloat(bounds.size.height * DrawingConstants.gallowHeight + DrawingConstants.gallowBaseHeight))
        let bottomRightPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowAcrossScale), y: bottomLeftPoint.y)
        let topLeftPoint = CGPoint(x: bottomLeftPoint.x, y: CGFloat(bounds.size.height * DrawingConstants.gallowHeight))
        let topRightPoint = CGPoint(x: CGFloat(bottomRightPoint.x), y: topLeftPoint.y)
        connectPoints(bottomLeftPoint: bottomLeftPoint, bottomRightPoint: bottomRightPoint, topLeftPoint: topLeftPoint, topRightPoint: topRightPoint, color: UIColor.brown)
    }
    
    func drawGallowTip() {
        let topLeftPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowAcrossScale - DrawingConstants.gallowHeightWidth), y: CGFloat(bounds.size.height * DrawingConstants.gallowHeight + DrawingConstants.gallowBaseHeight))
        let topRightPoint = CGPoint(x: CGFloat(bounds.size.width * DrawingConstants.gallowAcrossScale), y: topLeftPoint.y)
        let bottomLeftPoint = CGPoint(x: topLeftPoint.x, y: topLeftPoint.y + DrawingConstants.gallowTipHeight)
        let bottomRightPoint = CGPoint(x: topRightPoint.x, y: bottomLeftPoint.y)
        
        connectPoints(bottomLeftPoint: bottomLeftPoint, bottomRightPoint: bottomRightPoint, topLeftPoint: topLeftPoint, topRightPoint: topRightPoint, color: UIColor.brown)
    }
    
}
