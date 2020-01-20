//
//  VC_ArcadeGame.swift
//  TapIt
//
//  Created by Roe Iton on 01/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_ArcadeGame: UIViewController {
    
    @IBOutlet weak var img_Circle: UIImageView!
    
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btn_Screen: UIButton!
    @IBOutlet weak var btn_tryAgain: UIButton!
    @IBOutlet weak var btn_leader: UIButton!
    @IBOutlet weak var btn_Pause: UIButton!
    @IBOutlet weak var btn_coin: UIButton!
    
    @IBOutlet weak var lbl_Taps: UILabel!
    @IBOutlet weak var lbl_timer: UILabel!
    @IBOutlet weak var lbl_tapstobeat: UILabel!
    @IBOutlet weak var lbl_coins: UILabel!
    
    var game: ArcadeGame!
    var gameseconds: Int!
    var gamepaused = false;
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        game = ArcadeGame(controller: self, seconds: gameseconds);
    }

    @IBAction func btn_Screen(_ sender: Any) {
        if (game.getgameIsOn()){
            game.setTaps();
            img_Circle.pulsate();
            lbl_Taps.pulsate();
        }
        else {
            game.startGame();
        }
    }
    
    @IBAction func btn_coin(_ sender: Any) {
        game.collectCoin()
    }
    
    @IBAction func btn_tryAgain(_ sender: Any) {
        game.resetGame();
    }
    
    @IBAction func btn_back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_Pause(_ sender: Any) {
        
        if (gamepaused){
            game.resumeGame();
        }
        else {
            game.pauseGame();
        }
    }
    
    @IBAction func btn_leader(_ sender: Any) {
        performSegue(withIdentifier: "segue_arcade_leader", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_arcade_leader" {
            if let leaderBoardGame = segue.destination as? VC_LBGame {
                leaderBoardGame.classicgame = 0;
            }
        }
    }
}

