//
//  VC_ClassicMenu.swift
//  PressIt
//
//  Created by Roe Iton on 01/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_ClassicMenu: UIViewController {
    
    var chosenGame: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btn_classic3(_ sender: Any) {
        chosenGame = 3;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    
    @IBAction func btn_classic5(_ sender: Any) {
        chosenGame = 5;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    
    @IBAction func btn_classic10(_ sender: Any) {
        chosenGame = 10;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    
    @IBAction func btn_classic15(_ sender: Any) {
        chosenGame = 15;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    @IBAction func btn_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_NewClassicGame" {
            if let newClassicGame = segue.destination as? VC_ClassicGame {
                newClassicGame.gameseconds = chosenGame;
            }
        }
    }
}

