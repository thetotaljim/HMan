//
//  ViewController.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    /************************************************************/
    /*      InitialViewController Display Elements              */
    /************************************************************/
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBAction func easySelected(_ sender: AnyObject) {
        self.model.determineUserDifficulty(sender: sender)
        performSegue(withIdentifier: "MoveToGame", sender: nil)
    }
    @IBAction func normalSelected(_ sender: AnyObject) {
        self.model.determineUserDifficulty(sender: sender)
        performSegue(withIdentifier: "MoveToGame", sender: nil)
    }
    @IBAction func hardSelected(_ sender: AnyObject) {
        self.model.determineUserDifficulty(sender: sender)
        performSegue(withIdentifier: "MoveToGame", sender: nil)
    }
    
    //  Declare the model
    private(set) var model  = InitialModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Hide the Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
     // MARK: - Navigation - Segue to GameViewController
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MoveToGame"
        {
            if let destinationVC = segue.destination as? GameViewController {
                //  Instanciate the GameViewController's model with the user's
                //  selected difficulty.
                let gameModel = GameModel(diff: self.model.difficulty!)
                destinationVC.model = gameModel
            }
        }
     }
}

