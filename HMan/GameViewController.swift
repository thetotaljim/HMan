//
//  GameViewController.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit
/****************************************************************/
/*                                                              */
/*                      GAME VIEW CONTROLLER                    */
/*                                                              */
/*          UIViewController, and GameViewDataSource            */
/*                                                              */
/****************************************************************/




class GameViewController: UIViewController, GameViewDataSource {
    
    override var prefersStatusBarHidden : Bool {
        return true
    }    
    //  GameModel object for the GameViewController, connects it to the GameModel
    var model : GameModel? //= nil
    //  This viewModel object is used to connect the GameViewController to the
    //  GameView, so that the GameView can get information from the GameModel 
    //  via the GameViewController.
    weak var viewModel : GameViewDataSource?
    //  This is the GameView object to be displayed in the hangmanView GameView
    var myGameView : GameView?
    //  Outlets used to play the game
    @IBOutlet weak var hangmanView: GameView!
    @IBOutlet var myLetterButtons: [UIButton]!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessedLabel: UILabel!
    

    // MARK: GAMEVIEWDATASOURCE DELEGATE FUNCTIONS
    /************************************************************/
    /*  These methods will let the GameView have access to      */
    /*  the user's number of attempts and difficulty level so   */
    /*  it can use those values to determine how much of the    */
    /*  hangman to draw.                                        */
    /************************************************************/
    
    func numberOfGuessesLeft() -> Int {
        return (model?.attempts)!
    }
    func gameLevel() -> String
    {
        return (model?.difficulty!.rawValue)!
    }
    //  MARK: - VIEW DID LOAD
    /************************************************************/
    /*                                                          */
    /*                      VIEW DID LOAD                       */
    /*                                                          */
    /************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Here we instanciate the GameView and set the GameViewController
        //  as it's delegate.
        myGameView = GameView()
        self.hangmanView = myGameView
        self.hangmanView.delegate = self
        
        //  Round the letter buttons and give them a custom color
        for butt in myLetterButtons {
            butt.layer.cornerRadius = butt.bounds.size.width/2
            butt.backgroundColor = UIColor(red: 47.0/255.0, green: 55.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        }
        //  Here the function to determine the word or phrase that 
        //  the user will be guessing.
        
        print("TheGameViewController's model should have values now, lets check.")
        print("Here should be the user's difficulty: ", model?.difficulty)
        getRandomWord()
        
    }
    
    // MARK: - LETTER BUTTON
    @IBAction func letterButt(_ sender: AnyObject) {
        let butt = sender as! UIButton
        checkIfLetterExists(butt.titleLabel!.text! as NSString)
        
        // Change buttons' color to prevent the player to tap it again
        butt.backgroundColor = UIColor.lightGray
    }
    
    
    /****************************************************************/
    /*                                                              */
    /*                      GET_RANDOM_WORD_()                      */
    /*                                                              */
    /*  This getRandomWord() function is used to get a word from    */
    /*  the plist of words based on the user's selected difficulty  */
    /*                                                              */
    /****************************************************************/
    
    func getRandomWord() {
        
        /****************************************************/
        /*  A bunch of the code in this function needs to   */
        /*  to be moved to the model before I'm done,       */
        /*  except for the code used to change Outlets      */
        /****************************************************/
        //  Gets the root of my plist of words
        let dictRoot = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "MyPropertyList", ofType: "plist")!)
        //  THIS WILL PRINT THE DICTIONARY VALUES FOR DEBUGGING PURPOSES
        for (key,value) in dictRoot! {
            print ("\(key): \(value)")
        }
        //  This is an array of words based on the difficulty
        var myDiff : String
        //  Here the value of myDiff is set based on the users selected difficulty
        if (model?.difficulty == UserDiff.Easy){
            myDiff = "Easy"
        }
        else if (model?.difficulty == UserDiff.Hard){
            myDiff = "Hard"
        }
        else {
            myDiff = "Normal"
        }
        print("The value of myDiff is: ", myDiff)
        /*
        switch model?.difficulty?.hashValue {
        case UserDiff.Easy.hashValue?:
            myDiff = "Easy"
        case UserDiff.Hard.hashValue?:
            myDiff = "Hard"
        default:
            myDiff = "Normal"
        }
        */
        print("The user's difficulty is ", model?.difficulty.debugDescription)
        //  Here an array is generated from the plist
        let wordsArr = dictRoot?.object(forKey: myDiff) as! NSArray
        //  This is a random word taken from the previous array
        let randomWord = Int(arc4random() % UInt32(wordsArr.count))
        
        //  Init game variables
        //  Set the model's wordToGuess NSString object.
        model?.wordToGuess = "\(wordsArr[randomWord])" as NSString
        //  User the model wordToGuess value to set the label that 
        //  is used to display the word used for that game.
        print("The model's wordToGuess is ", model?.wordToGuess)
        setupWord((model?.wordToGuess)!)
        //  Set the attempts in the model to 0 to start the game.
        model?.attempts = 0
        print("WORD TO GUESS: \(model?.wordToGuess)")
        
        //  Here i would need to add the appropriate hangman view
        //  This could be done using the image i have used so far
        //  use the model to set the view model, then let it pick how to make
        //  the view appear.
        //hangmanImage.image = UIImage(named: "h\(attempts)")
        
        self.hangmanView.setNeedsLayout()
 
    }
    
    
    // MARK: - SETUP WORD
    func setupWord(_ word:NSString) {
        
        let myString = model?.wordToGuess as! String
        let fixed = myString.replacingOccurrences(of: "[A-Z]", with: "•", options: .regularExpression, range: myString.startIndex..<myString.endIndex)
        wordLabel.text = ""
        wordLabel.text = fixed
    }
    
    // MARK: - CHECK IF THE CHOOSE LETTER DOES EXIST
    func checkIfLetterExists(_ letterToCheck:NSString) {
        // Flag for noting whether button character matches a character in the word string
        var match = false
        var letterRange = NSRange()
        let charToCheck = letterToCheck.character(at: 0)
        print("CharToCheck = ", charToCheck)
        /********************************************************************/
        /* HERE WE CHECK TO SEE IF USERS SELECTED LETTER IS IN THE WORD     */
        /********************************************************************/
        let len = model?.wordToGuess.length
        for i in 0..<Int(len!) {
            let tempChar = model?.wordToGuess.character(at: i)
            if charToCheck == tempChar {
                match = true
                letterRange = NSMakeRange(i, 1)
                let wordStr:NSString = wordLabel.text! as NSString
                wordLabel.text = wordStr.replacingCharacters(in: letterRange, with: String(letterToCheck))
                print("CHECKING WORD: \(wordLabel.text!)")
                
                /************************************************************/
                /*  HERE IS WHERE A WIN IS DETERMINED                       */
                /************************************************************/
                if wordLabel.text! == model?.wordToGuess as! String  {
                    guessedLabel.text = "You've guessed the word!\nGetting a new word..."
                  
                }
            }
        }
        
        // LETTER DOES NOT EXIST --------------------------------------------------
        if !match {
            print("Here is another incorrect letter match.")
            model?.attempts += 1
            
            //self.hangmanView.drawBody(numberOfGuesses: (model?.guessNumber.rawValue)!)
            self.hangmanView.startDrawChain(numberOfGuesses: (model?.guessNumber.rawValue)!)
            //self.hangmanView.incorrectGuesses+=1
            //self.hangmanView.setNeedsDisplay()
            //myGameView?.incorrectGuesses+=1
            //myGameView?.setNeedsDisplay()
            //hangmanView.setNeedsDisplay()
            //hangmanView.setNeedsLayout()
            //hangmanView.incorrectGuesses+=1
            // GAME OVER!
            if (model?.attempts)! > (model?.guessNumber.rawValue)! { gameOver() }
            //hangmanImage.image = UIImage(named: "h\(attempts)")
            //hangmanView.drawBody(numberOfGuesses: model.)
            
        }
    }
    
    
    // MARK: - GAME OVER FUNCTION
    func gameOver() {
        let goVC = storyboard?.instantiateViewController(withIdentifier: "FinalViewController") as! FinalViewController
        //goVC.model?.wordNotGuessed = model?.wordToGuess as String
        navigationController?.pushViewController(goVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
