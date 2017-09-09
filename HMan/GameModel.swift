//
//  GameModel.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

//  Enum to handle the number of guesses per difficulty
enum DiffGuessNum : Int {
    case Easy = 9
    case Normal = 8
    case Hard = 6
    
}

/************************************************************/
/*      Methods for the GameViewController to               */
/*      implement.                                          */
/************************************************************/

protocol GameModelDelegate : class {
    func setWordLabel(word: NSString)
    func setGuessedLabel(word: NSString)
    func setAttributedString(text: NSMutableAttributedString)
    func gameOver()
    func addABodyPart(part: BodyPart)
    func getWordLabelText() -> NSString
}

/************************************************************/
/*      Model for the GameViewController                    */
/*                                                          */
/*  This model handles the data and processes               */
/*  for playing a game of Hangman.                          */
/************************************************************/
class GameModel  {
    
    //  Game Model Variables
    weak var delegate : GameModelDelegate?
    private var difficulty: UserDiff?
    //  Set to normal as default
    private var guessNumber = DiffGuessNum.Normal
    private var wantsToQuit: Bool = false
    private(set) var wordToGuess = NSString()
    private(set) var attempts = 0
    private var score = 0
    private var guessedArray = [NSString]()
    private var youWon : Bool = false
    
    func getWinOrLose()->Bool{
        return youWon
    }

    init(diff: UserDiff){
        self.difficulty = diff
        setDiffGuessNum()
    }
    
    func setDiffGuessNum() {
        if ( difficulty == UserDiff.Easy){
            guessNumber = DiffGuessNum.Easy
        }
        else if ( difficulty == UserDiff.Hard){
            guessNumber = DiffGuessNum.Hard
        }
        else {
            guessNumber = DiffGuessNum.Normal
        }
    }
    
    /********************************************************************/
    /*                                                                  */
    /*   SET THE WORD THAT THE USER WILL TRY AND GUESS  getRandWord()   */
    /*                                                                  */
    /********************************************************************/
    
    func getRandomWord() {
        
        //  Gets the root of my plist of words
        let dictRoot = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "MyPropertyList", ofType: "plist")!)
        //  Here an array is generated from the plist
        let wordsArr = dictRoot?.object(forKey: (difficulty?.rawValue)!) as! NSArray
        //  This is a random word taken from the previous array
        let randomWord = Int(arc4random() % UInt32(wordsArr.count))
        //  Set the wordToGuess NSString object.
        wordToGuess = "\(wordsArr[randomWord])" as NSString
        //  User the wordToGuess value to set the label that
        //  is used to display the word used for that game.
        setupWord((wordToGuess))
        //  Set the attempts in the model to 0 to start the game.
        attempts = 0
        
    }
    
    /********************************************************************/
    /*  Here we perform some formatting on the word being guessed       */
    /*  so it displays properly in the WordGuess label in the           */
    /*  GameViewController.                                             */
    /********************************************************************/
    func getAttributedString(string: String) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(1.9), range: NSRange(location: 0, length: string.characters.count))
        return attributedString
    }
    
    /********************************************************************/
    /*  This method takes the word from the plist and formats it by     */
    /*  replacing the characters in the word and replacing them with    */
    /*  "_" while preserving whitespaces in between words.              */
    /********************************************************************/
    func setupWord(_ word: NSString) {
        
        let myString = wordToGuess as String
        let fixed = myString.replacingOccurrences(of: "[A-Z]", with: "_", options: .regularExpression, range: myString.startIndex..<myString.endIndex)
        delegate?.setWordLabel(word: "")
        delegate?.setWordLabel(word:fixed as NSString)
        var attribStrng = NSMutableAttributedString()
        attribStrng = getAttributedString(string: fixed)
        delegate?.setAttributedString(text: attribStrng)
        
    }
    
    /********************************************************************/
    /*  This method checks to see if the letter the user selected is    */
    /*  in the word they are trying to guess. If so, it replaces the    */
    /*  "_" in the word label with the letter, and checks to see if     */
    /*  the word has been successfully guessed. If not, it will         */
    /*  update the hangman and check to see if the game has ended.      */
    /********************************************************************/
    func checkIfLetterExists(_ letterToCheck:NSString) {
        
        if guessedArray.contains(letterToCheck){
            return
        }
        else {
            guessedArray.append(letterToCheck)
        }
        // Flag for noting whether button character matches a character in the word string
        var match = false
        var letterRange = NSRange()
        let charToCheck = letterToCheck.character(at: 0)
        
        /********************************************************************/
        /* HERE WE CHECK TO SEE IF USERS SELECTED LETTER IS IN THE WORD     */
        /********************************************************************/
        let len = wordToGuess.length
        for i in 0..<Int(len) {
            let tempChar = wordToGuess.character(at: i)
            if charToCheck == tempChar {
                match = true
                letterRange = NSMakeRange(i, 1)
                let wordStr:NSString = (delegate?.getWordLabelText())!
                let tempString = wordStr.replacingCharacters(in: letterRange, with: String(letterToCheck))
                var attribStrng = NSMutableAttributedString()
                attribStrng = getAttributedString(string: tempString)
                delegate?.setAttributedString(text: attribStrng)
                
                /************************************************************/
                /*  HERE IS WHERE A WIN IS DETERMINED                       */
                /************************************************************/
                if delegate?.getWordLabelText() == (wordToGuess) {
                    delegate?.setGuessedLabel(word: "You've guessed the word!" as NSString)
                    youWon = true
                    delegate?.gameOver()
                }
            }
        }
        /********************************************************************/
        /*         IF THE LETTER DOES NOT MATCH ANY IN THE WORD             */
        /********************************************************************/
        if !match {
            attempts += 1
            
            // IF THE USER IS OUT OF GUESSES = GAME OVER!
            if (attempts) > (guessNumber.rawValue) { delegate?.gameOver() }
            //  OTHERWISE ADD A NEW BODY PART AND UPDATE THE WORD TO GUESS LABEL
            delegate?.addABodyPart(part: BodyPart(rawValue: attempts)!)
            delegate?.setGuessedLabel(word: "You have \(guessNumber.rawValue-attempts+1) guesses left!" as NSString)
        }
    }
    
}
