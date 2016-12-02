//
//  GameView.swift
//  HMan
//
//  Created by James Steimel on 11/30/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//
protocol GameViewDataSource: class {
    
    func numberOfGuessesLeft() -> Int
    func gameLevel() -> String
}

import UIKit

//MARK - Global Function

func drawLine(startPoint: CGPoint, endPoint: CGPoint) {
    let path = UIBezierPath()
    path.lineWidth = CGFloat(2)
    path.move(to: startPoint)
    path.addLine(to: endPoint)
    path.stroke()
}

class GameView: GallowsView {
    
    
    /************************************/
    /*  This var is an attempt to       */
    /*  force the view to redraw with   */
    /*  the appropriate appendages.     */
    /************************************/
    
    var incorrectGuesses = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    //MARK - Drawing Scales and Constants
    
    struct ScaleConstants {
        static let bodyLength: CGFloat = 50
        static let limbLength: CGFloat = 25
        static let handHeightScale: CGFloat = 0.4
        static let headRadius: CGFloat = 20
        static let eyeRadius = CGFloat(0.15 * ScaleConstants.headRadius)
        static let eyeOffset = CGFloat(0.3 * ScaleConstants.headRadius)
        static let mouthOffSet = CGFloat(0.3 * ScaleConstants.headRadius)
        static let mouthRadius = CGFloat(0.25 * ScaleConstants.headRadius)
    }
    
    //MARK - Properties
    
    weak var delegate : GameViewDataSource?
    
    private var bodyStart: CGPoint = CGPoint.zero
    
    private var bodyEnd: CGPoint = CGPoint.zero
    
    private var headMiddle: CGPoint = CGPoint.zero
    
    //MARK - Drawing functions
    
    override func draw(_ rect: CGRect) {
        print("Here we enter the draw(_ rect:CGRect) override method.")
        //drawSky()
        //drawGrass()
        print("Calling drawGallow()")
        drawGallow()
        //  Here i will test to see if full figure looks the way i would want
        //let level = dataSource?.gameLevel()
        //let level = "Medium"
        let level = delegate?.gameLevel()
        print("Here is the delegate's gameLevel() response: ", delegate?.gameLevel())
        //let guesses = dataSource?.numberOfGuessesLeft()
        let guesses = delegate?.numberOfGuessesLeft()
        print("Here are the number of delegate's guesses: ", delegate?.numberOfGuessesLeft())
        //let guesses = 0
        var wrongGuessesSoFar = 0
        var maxGeusses = 0
        if let theLevel = level {
            switch theLevel {
            case "Hard":
                maxGeusses = 6
            case "Normal":
                maxGeusses = 8
            case "Easy":
                maxGeusses = 10
            default: break
            }
        }
        maxGeusses = incorrectGuesses
        print("The number of maxGeusses is: ", maxGeusses)
        if let myGuesses = guesses {
            wrongGuessesSoFar = maxGeusses - myGuesses
            print("The value of wrongGuessesSoFar is: ", wrongGuessesSoFar)
        }
        print("Starting the drawChain!")
        startDrawChain(numberOfGuesses: wrongGuessesSoFar)
    }
    
    func startDrawChain(numberOfGuesses: Int) {
        drawHead(numberOfGuesses: numberOfGuesses)
    }
    
    func drawHead(numberOfGuesses: Int) {
        
        if numberOfGuesses == 0 {
            return
        } else {
            let centerX = CGFloat(bounds.size.width * DrawingConstants.gallowAcrossScale - (DrawingConstants.gallowHeightWidth / 2))
            let centerY = CGFloat(bounds.size.height * DrawingConstants.gallowHeight + DrawingConstants.gallowBaseHeight + DrawingConstants.gallowTipHeight + ScaleConstants.headRadius)
            let center = CGPoint(x: centerX, y: centerY)
            headMiddle = center
            
            UIColor.black.set()
            let path = UIBezierPath(arcCenter: center, radius: ScaleConstants.headRadius, startAngle: CGFloat(0), endAngle: CGFloat(2 * M_PI), clockwise: true)
            path.lineWidth = CGFloat(2)
            path.stroke()
            drawBody(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawBody(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            UIColor.black.set()
            let add = CGFloat(DrawingConstants.gallowBaseHeight + DrawingConstants.gallowTipHeight + 2 * ScaleConstants.headRadius)
            let startPointY = CGFloat(bounds.size.height * DrawingConstants.gallowHeight + add)
            let startPointX = CGFloat(bounds.size.width * DrawingConstants.gallowAcrossScale - (DrawingConstants.gallowHeightWidth / 2))
            let startPoint = CGPoint(x: startPointX, y: startPointY)
            let endPoint = CGPoint(x: startPoint.x, y: startPoint.y + ScaleConstants.bodyLength)
            bodyStart = startPoint
            bodyEnd = endPoint
            drawLine(startPoint: startPoint, endPoint: endPoint)
            drawLeftLeg(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawLeftLeg(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            let startPoint = CGPoint(x: bodyEnd.x, y: bodyEnd.y)
            let endPoint = CGPoint(x: startPoint.x - ScaleConstants.limbLength, y: startPoint.y + ScaleConstants.limbLength)
            drawLine(startPoint: startPoint, endPoint: endPoint)
            drawRightLeg(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawRightLeg(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            let startPoint = CGPoint(x: bodyEnd.x, y: bodyEnd.y)
            let endPoint = CGPoint(x: startPoint.x + ScaleConstants.limbLength, y: startPoint.y + ScaleConstants.limbLength)
            drawLine(startPoint: startPoint, endPoint: endPoint)
            drawLeftArm(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawLeftArm(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            let startPoint = CGPoint(x: bodyStart.x, y: bodyStart.y + ScaleConstants.handHeightScale * ScaleConstants.bodyLength)
            let endPoint = CGPoint(x: startPoint.x - ScaleConstants.limbLength, y: startPoint.y - ScaleConstants.limbLength * ScaleConstants.handHeightScale)
            drawLine(startPoint: startPoint, endPoint: endPoint)
            drawRightArm(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawRightArm(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            let startPoint = CGPoint(x: bodyStart.x, y: bodyStart.y + ScaleConstants.handHeightScale * ScaleConstants.bodyLength)
            let endPoint = CGPoint(x: startPoint.x + ScaleConstants.limbLength, y: startPoint.y - ScaleConstants.limbLength * ScaleConstants.handHeightScale)
            drawLine(startPoint: startPoint, endPoint: endPoint)
            drawLeftEye(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawLeftEye(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            UIColor.black.set()
            let eyeMiddle = CGPoint(x: headMiddle.x - ScaleConstants.eyeOffset, y: headMiddle.y - ScaleConstants.eyeOffset)
            
            let path = UIBezierPath(arcCenter: eyeMiddle, radius: ScaleConstants.eyeRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
            path.lineWidth = CGFloat(1)
            path.stroke()
            drawRightEye(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawRightEye(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            UIColor.black.set()
            let eyeMiddle = CGPoint(x: headMiddle.x + ScaleConstants.eyeOffset, y: headMiddle.y - ScaleConstants.eyeOffset)
            
            let path = UIBezierPath(arcCenter: eyeMiddle, radius: ScaleConstants.eyeRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
            path.lineWidth = CGFloat(1)
            path.stroke()
            drawMouth(numberOfGuesses: numberOfGuesses - 1)
        }
    }
    
    func drawMouth(numberOfGuesses: Int) {
        if numberOfGuesses == 0 {
            return
        } else {
            UIColor.black.set()
            let mouthMiddle = CGPoint(x: headMiddle.x, y: headMiddle.y + ScaleConstants.mouthOffSet)
            
            let path = UIBezierPath(arcCenter: mouthMiddle, radius: ScaleConstants.mouthRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
            path.lineWidth = CGFloat(1)
            path.stroke()
        }
    }
}
