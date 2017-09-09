//
//  FinalViewController.swift
//  HMan
//
//  Created by James Steimel on 11/30/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

/****************************************************************/
/*  This FinalViewController displays the result, whether the   */
/*  user won or lost, the number of incorrect guesses, and the  */
/*  word they were trying to guess.                             */
/****************************************************************/

class FinalViewController: UIViewController {
    
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBAction func returnToHome(_ sender: AnyObject) {
         performSegue(withIdentifier: "MoveToHome", sender: nil)
    }
    //  FinalModel 
    var model : FinalModel?
    //  View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.topLabel.text = model?.getDisplayWord()
        self.midLabel.text = String(describing: (model?.getNumOfGuesses())! )
        self.resultsLabel.text = (model?.getResultsString())!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  This is here in case I wanted to start tracking score or wins 
        //  and passing this back and forth 
        /*
        if segue.identifier == "MoveToHome"
        {
            if let destinationVC = segue.destination as? FinalViewController {
                
            }
        }
        */
    }
}
