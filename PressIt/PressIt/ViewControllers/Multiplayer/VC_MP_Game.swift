//
//  VC_MP_GAME.swift
//  PressIt
//
//  Created by Roe Iton on 21/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit
import SocketIO
import SAConfettiView

class VC_MP_Game: UIViewController {
    
    var SC: ServerConversation!
    var isHost: Bool!
    
    var gamecode: String!
    
    @IBOutlet weak var circularProgress: CircularProgressView!
    var level_status: Float!
    
    @IBOutlet weak var img_Circle: UIImageView!
    
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var btn_Screen: UIButton!
    @IBOutlet weak var btn_Start: UIButton!
    @IBOutlet weak var btn_Leader: UIButton!
    
    @IBOutlet weak var lbl_Taps: UILabel!
    @IBOutlet weak var lbl_timer: UILabel!
    @IBOutlet weak var lbl_levelStatus: UILabel!
    
    var game: MultiplayerGame!
    var gameseconds: Int!
    
    override func viewDidLoad() {
        lbl_levelStatus.text = String(Int(getPrecentOfLevel() * 100)) + "%";
        gameseconds = 5;
        circularProgress.progressClr = UIColor.white
        circularProgress.trackClr = UIColor.init(red: 184, green: 244, blue: 199, alpha: 1)
        game = MultiplayerGame(controller: self, seconds: gameseconds);
        add_handlers();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        circularProgress.setProgressWithAnimation(duration: 1.0, value: getPrecentOfLevel());
    }
    
    func update_LevelProgress(){
        let level_rounded = Int(getPrecentOfLevel() * 100);
        
        lbl_levelStatus.text = String(level_rounded) + "%";
        
        circularProgress.setProgressWithOutAnimation(value: getPrecentOfLevel());
        
    }
    
    func getPrecentOfLevel() -> Float{
        var precent = level_status / Float(getCountToNextLevel());
        
        if (precent >= 1.0){
            levelUP();
            precent = 0;
        }
        
        return precent;
    }
    
    func levelUP(){
        
        if (MP_PLAYER_LEVEL == "12"){
            return;
        }
        
        showConfetti();
        
        level_status = 0;
        MP_PLAYER_LEVEL_STATUS = "0.0";
        MP_PLAYER_LEVEL = String((MP_PLAYER_LEVEL as NSString).integerValue + 1);
        
        if (SIGNEDIN){
            UserDefaults.standard.set(MP_PLAYER_LEVEL, forKey: "PLAYER_LEVEL");
            UserDefaults.standard.set("0.0", forKey: "PLAYER_LEVEL_STATUS");
            
            self.SC.updateUserLevel(username: MP_PLAYER_NICKNAME, level: MP_PLAYER_LEVEL, level_status: MP_PLAYER_LEVEL_STATUS)
        }
    }
    
    func showConfetti(){
        let confettiView = startConfetti();
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.stopConfetti(conefettiView: confettiView)
        })
        
    }
    
    func add_LevelProgress() {
        level_status += 0.1;
        
        update_LevelProgress()
    }
    
    
    func getCountToNextLevel() -> Int{
        switch ((MP_PLAYER_LEVEL as NSString).integerValue + 1){
        case 2: return 40;
        case 3: return 120;
        case 4: return 210;
        case 5: return 300;
        case 6: return 380;
        case 7: return 460;
        case 8: return 530;
        case 9: return 600;
        case 10: return 660;
        case 11: return 720;
        case 12: return 780;
        default: return 0;
        }
    }
    
    
    func add_handlers(){
        SC.socket.on("startgame") {data, ack in
            print("START GAME!")
            self.game.startCountToPlay();
        }
    }
    
    func updateHiddenButtons(b: Bool!) {
        //btn_Start.isHidden = !b;
        //btn_back.isHidden = !b;
        //btn_leader.isHidden = !b;
        btn_Screen.isHidden = !b;
    }

    @IBAction func btn_Screen(_ sender: Any) {
        if (game.getgameIsOn()){
            game.setTaps();
            add_LevelProgress()
            circularProgress.pulsate();
            lbl_Taps.pulsate();
        }
    }
    
    @IBAction func btn_Start(_ sender: Any) {
        SC.socket.emit("startgame", gamecode!)
        
        SC.socket.on("startgame") {data, ack in
            self.game.startCountToPlay();
        }
        //game.resetGame();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "segue_HSC" {
         //   if let leaderBoardGame = segue.destination as? VC_LBGame {
         //       leaderBoardGame.classicgame = gameseconds;
        //    }
        //}
    }
}
