//
//  FinalModel.swift
//  HMan
//
//  Created by James Steimel on 11/30/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

//  Used so model can display results of the game.
protocol FinalModelDelegate: class {
    func displayResultString()->String
}

/********************************************************/
/*  Here is the model for the FinalViewController       */
/*  It displays the word that was being guessed, the    */
/*  win/loss message, and the number of incorrect       */
/*  guesses.                                            */
/********************************************************/
class FinalModel  {
    
    var delegate : FinalModelDelegate?
    private var displayWord: String = ""
    private var numOfGuesses: Int = 0
    private var youWon : Bool = false
    private var winString : String = "Congratulations! You guessed your word!"
    private var loseString : String = "Sorry, better luck next time!"
    
    init(word: String, guesses: Int, winOrLose: Bool){
        self.displayWord = word
        self.numOfGuesses = guesses
        self.youWon = winOrLose
    }
    
    func getResultsString()->String{
        if (youWon == true){
            return winString
        }
        return loseString
    }
    
    func getDisplayWord()-> String{
        return displayWord
    }
    func getNumOfGuesses()->Int{
        return numOfGuesses
    }
    func getWinOrLose()->Bool{
        return youWon
    }

}
