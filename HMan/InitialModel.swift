//
//  InitalModel.swift
//  HMan
//
//  Created by James Steimel on 11/29/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

//  Enum for user difficulty
enum UserDiff : String{
    case Easy = "Easy"
    case Normal = "Normal"
    case Hard = "Hard"
}

import UIKit
/********************************************************/
/*          InitialViewController Model                 */
/*                                                      */
/*      Used for determininge the user's selected       */
/*                  difficutly                          */
/********************************************************/

class InitialModel {

    private(set) var difficulty: UserDiff?
    
    func determineUserDifficulty(sender: AnyObject){
        let id: String? = sender.restorationIdentifier
        if id == UserDiff.Easy.rawValue {
            difficulty = UserDiff.Easy
        }
        else if id == UserDiff.Hard.rawValue {
            difficulty = UserDiff.Hard
        }
        else {
            difficulty = UserDiff.Normal
        }
    }
}
