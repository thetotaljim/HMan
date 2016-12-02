//
//  GameModel.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

enum DiffGuessNum : Int {
    case Easy = 6
    case Normal = 8
    case Hard = 10
    
}


class GameModel  {
    
    weak var gameView : GameView?
    
    var difficulty: UserDiff?
    //  Set to normal as default
    var guessNumber = DiffGuessNum.Normal
    
    var wordToGuess = NSString()
    var attempts = 0
    var score = 0
    
    let DifficultyList = [
        "Easy",
        "Normal",
        "Hard",
    ]
    
    init(diff: UserDiff){
        self.difficulty = diff
        //gameView?.delegate = self
    }
  
    func randomWordGenerator() {
        
    }
    
    func makeSetupWord() {
        
    }
    
    }
