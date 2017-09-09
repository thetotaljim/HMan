//
//  GameViewController.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

//  This is for modifying the space in between characters in a label.
extension UILabel {
    func addTextSpacing(_ spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: text!)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: text!.characters.count))
    }
}

import UIKit
/****************************************************************/
/*                                                              */
/*                      GAME VIEW CONTROLLER                    */
/*                                                              */
/*          UIViewController, and GameModelDelegate             */
/*                                                              */
/****************************************************************/
class GameViewController: UIViewController, GameModelDelegate {
    
    var model : GameModel?
    @IBOutlet weak var hangmanView: HangmanView!
    @IBOutlet var myLetterButtons: [UIButton]!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessedLabel: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    //  If the user selects to return, they are chicken tested here with UIAlertController.
    @IBAction func returnToTitlePage(_ sender: AnyObject) {
            let alert = UIAlertController.init(title: "Are You Sure You Want To Quit?", message: "You are about to return to the Title Page.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Yes, Go Back", style: .default, handler: { action in self.returnToTitlePage() }))
            alert.addAction(UIAlertAction.init(title: "Keep Playing", style: .default, handler: {action in self.nothin()}))
            self.present(alert, animated: true, completion:nil)
    }
    /************************************************************/
    /*                                                          */
    /*          HERE ARE THE GAME MODEL DELEGATE METHODS        */
    /*                                                          */
    /************************************************************/
    
    func setAttributedString(text: NSMutableAttributedString){
        wordLabel.attributedText = text
    }
    func setWordLabel(word: NSString){
        wordLabel.text = word as String
    }
    func setGuessedLabel(word: NSString){
        guessedLabel.text = word as String
    }
    func addABodyPart(part: BodyPart){
        self.hangmanView.add(part: part)
        self.hangmanView.setNeedsLayout()
        self.hangmanView.setNeedsDisplay()
    }
    func getWordLabelText() -> NSString {
        let wordStr: NSString = wordLabel.text! as NSString
        return wordStr
    }
    // MARK: - GAME OVER FUNCTION
    func gameOver() {
        performSegue(withIdentifier: "MoveToFinal", sender: nil)
    }
    
    //  MARK: - VIEW DID LOAD
    /************************************************************/
    /*                                                          */
    /*                      VIEW DID LOAD                       */
    /*                                                          */
    /************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Round the letter buttons and give them a custom color
        for butt in myLetterButtons {
            butt.layoutIfNeeded()
            print("Editing a button: ", butt.title(for: .normal))
            butt.layer.cornerRadius = butt.bounds.size.width/2
            butt.backgroundColor = UIColor(red: 0.60, green: 0.83, blue: 0.87, alpha: 1.0)
            butt.setTitleColor(UIColor.white, for: .normal)
        }
        self.model?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        model?.getRandomWord()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    /************************************************************/
    /*              LETTER BUTTON                               */
    /************************************************************/
    @IBAction func letterButt(_ sender: AnyObject) {
        let butt = sender as! UIButton
        model?.checkIfLetterExists(butt.titleLabel!.text! as NSString)
        // Change buttons' color to prevent the player to tap it again
        butt.backgroundColor = UIColor(red: 0.19, green: 0.17, blue: 0.20, alpha: 1.0)
        butt.setTitleColor(UIColor.white, for: .normal)
    }
    
    /************************************************************/
    /*              NAVIGATION                                  */
    /************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveToFinal"
        {
            if let destinationVC = segue.destination as? FinalViewController {
                let finalModel = FinalModel(word: (model?.wordToGuess as? String)!, guesses: (model?.attempts)!, winOrLose: (model?.getWinOrLose())!)
                destinationVC.model = finalModel
            }
        }
    }
    
    /************************************************************/
    /*              ReturnToTitlePage                           */
    /************************************************************/
    func returnToTitlePage() {
        let goVC = storyboard?.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        navigationController?.pushViewController(goVC, animated: true)
    }
    //  placeholder function
    func nothin(){}
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
