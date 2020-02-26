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
    
    var ui: UI!;
    var SC: ServerConversation!
    var isHost: Bool!
    
    var gamecode: String!
    var playerID: String!
    
    @IBOutlet weak var circularProgress: CircularProgressView!
    var level_status: Float!
    
    @IBOutlet weak var background: UIImageView!
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
    
    func adjustUI(){
        btn_Screen.frame.size = self.view.frame.size;
        btn_Screen.frame.origin = CGPoint(x: 0, y: 0);
        
        if (UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_game_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            
            circularProgress.frame.size.width += 40;
            circularProgress.frame.size.height += 40;
            
            btn_Start.frame.origin.y += 15;
            circularProgress.frame.origin.y = self.view.frame.height / 2 - 140
            circularProgress.frame.origin.x -= 0;
            lbl_Taps.frame.origin.y = self.view.frame.height / 2 - 60;
            lbl_timer.frame.origin.y += 18;
            lbl_levelStatus.frame.origin.y =  lbl_Taps.frame.origin.y + 64;
            btn_Back.frame.origin.y += 18;
            btn_Leader.frame.origin.y += 18;

            btn_Start.frame.origin = ui.getNewLocation(old_location: btn_Start.frame.origin)
        }
        else if (UIDevice.modelName == "iPhone 11 Pro"){
            //Undone yet
            background.image = UIImage(named: "bkg_game_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            
            
            btn_Start.frame.origin.y += 100;
            circularProgress.frame.origin.y += 40;
            lbl_Taps.frame.origin.y += 40;
            lbl_timer.frame.origin.y += 40;
            lbl_levelStatus.frame.origin.y += 40;
            
            btn_Start.frame.origin.x -= 20;
            circularProgress.frame.origin.x -= 20;
            lbl_Taps.frame.origin.x -= 20;
            lbl_timer.frame.origin.x -= 20;
            lbl_levelStatus.frame.origin.x -= 20;
            btn_Leader.frame.origin.x -= 34;
            btn_Back.frame.origin.y += 18;
            btn_Leader.frame.origin.y += 18;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        
        // img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        //btn_Multiplayer.frame.origin = ui.getNewLocation(old_location: btn_Multiplayer.frame.origin)
        //lbl_Copyright.frame.origin = ui.getNewLocation(old_location: lbl_Copyright.frame.origin)
        
        //img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        //background.frame.size = ui.getNewSize(old_size: background.frame.size)
        btn_Start.frame.size = ui.getNewSize(old_size: btn_Start.frame.size)
        //btn_Multiplayer.frame.size = ui.getNewSize(old_size: btn_Multiplayer.frame.size)
        //lbl_Copyright.frame.size = ui.getNewSize(old_size: lbl_Copyright.frame.size)
    }
    
    override func viewDidLoad() {
        ui = UI (size: self.view.frame.size);
        circularProgress.progressClr = UIColor.white
        circularProgress.trackClr = UIColor.init(red: 184, green: 244, blue: 199, alpha: 1)
        adjustUI()
        
        SC.addViewGame(view: self)
        
        lbl_levelStatus.text = String(Int(getPrecentOfLevel() * 100)) + "%";
        gameseconds = 5;
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
        MP_PLAYER_LEVEL_STATUS = String(level_status)
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
    
    @IBAction func btn_Score(_ sender: Any) {
        SC.socket.emit("get_score", gamecode!);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    @IBAction func btn_Back(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "Leave game?", message: "Are you sure you want to leave game?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Leave", style: UIAlertAction.Style.destructive) { (alertAction) in
            //self.SC.userExit(playerID: self.playerID, gameID: self.gamecode)
            self.dismissViewController()
        })
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) in })

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
