//
//  VC_LBMenu.swift
//  PressIt
//
//  Created by Roe Iton on 03/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_LBMenu: UIViewController {
    
    var chosenGame: Int!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_classic3(_ sender: Any) {
        chosenGame = 3;
        performSegue(withIdentifier: "segue_HSClassicGame", sender: self);
    }
    
    @IBAction func btn_classic5(_ sender: Any) {
        chosenGame = 5;
        performSegue(withIdentifier: "segue_HSClassicGame", sender: self);
    }
    
    @IBAction func btn_classic10(_ sender: Any) {
        chosenGame = 10;
        performSegue(withIdentifier: "segue_HSClassicGame", sender: self);
    }
    
    @IBAction func btn_classic15(_ sender: Any) {
        chosenGame = 15;
        performSegue(withIdentifier: "segue_HSClassicGame", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_HSClassicGame" {
            if let leaderBoardGame = segue.destination as? VC_LBGame {
                leaderBoardGame.classicgame = chosenGame;
            }
        }
    }
}
