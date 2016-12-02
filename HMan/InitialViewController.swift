//
//  ViewController.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBAction func easySelected(_ sender: AnyObject) {
        self.model.difficulty = UserDiff.Easy
        performSegue(withIdentifier: "MoveToGame", sender: nil)
    }
    @IBAction func normalSelected(_ sender: AnyObject) {
        self.model.difficulty = UserDiff.Normal
        performSegue(withIdentifier: "MoveToGame", sender: nil)
    }
    @IBAction func hardSelected(_ sender: AnyObject) {
        self.model.difficulty = UserDiff.Hard
        performSegue(withIdentifier: "MoveToGame", sender: nil)
    }
    
    
    var model  = InitialModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MoveToGame"
        {
            if let destinationVC = segue.destination as? GameViewController {
                let gameModel = GameModel(diff: self.model.difficulty!)
                destinationVC.model = gameModel
            }
        }     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 
}

