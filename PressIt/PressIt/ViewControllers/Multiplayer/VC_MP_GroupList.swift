//
//  VC_ArcadeGame.swift
//  TabIt
//
//  Created by Roe Iton on 03/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//


import Foundation
import UIKit
import SocketIO

var room: Room!

class VC_MP_GroupList: UIViewController {
    
    var ui: UI!;
    var SC: ServerConversation!
    
    var isHost: Bool!
    
    @IBOutlet weak var btn_EnterGame: UIButton!
    @IBOutlet weak var lbl_GameID: UILabel!
    
    var gamecode: String!
    var playerID: String!
    
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    
    
    
    @IBOutlet weak var lbl_player1: UILabel!
    @IBOutlet weak var lbl_player2: UILabel!
    @IBOutlet weak var lbl_player3: UILabel!
    @IBOutlet weak var lbl_player4: UILabel!
    @IBOutlet weak var lbl_player5: UILabel!
    @IBOutlet weak var lbl_player_lvl_1: UILabel!
    @IBOutlet weak var lbl_player_lvl_2: UILabel!
    @IBOutlet weak var lbl_player_lvl_3: UILabel!
    @IBOutlet weak var lbl_player_lvl_4: UILabel!
    @IBOutlet weak var lbl_player_lvl_5: UILabel!
    @IBOutlet weak var bar_player1: UIImageView!
    @IBOutlet weak var bar_player2: UIImageView!
    @IBOutlet weak var bar_player3: UIImageView!
    @IBOutlet weak var bar_player4: UIImageView!
    @IBOutlet weak var bar_player5: UIImageView!
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            
            
            
            btn_EnterGame.frame.origin.y += 160;
            lbl_GameID.frame.origin.y += 100;
            lbl_player1.frame.origin.y += 100;
            lbl_player2.frame.origin.y += 100;
            lbl_player3.frame.origin.y += 100;
            lbl_player4.frame.origin.y += 100;
            lbl_player5.frame.origin.y += 100;
            lbl_player_lvl_1.frame.origin.y += 100;
            lbl_player_lvl_2.frame.origin.y += 100;
            lbl_player_lvl_3.frame.origin.y += 100;
            lbl_player_lvl_4.frame.origin.y += 100;
            lbl_player_lvl_5.frame.origin.y += 100;
            bar_player1.frame.origin.y += 100;
            bar_player2.frame.origin.y += 100;
            bar_player3.frame.origin.y += 100;
            bar_player4.frame.origin.y += 100;
            bar_player5.frame.origin.y += 100;
            btn_back.frame.origin.y += 18;
            btn_profile.frame.origin.y += 18;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            
            
            
            btn_EnterGame.frame.origin.y += 100;
            lbl_GameID.frame.origin.y += 40;
            lbl_player1.frame.origin.y += 40;
            lbl_player2.frame.origin.y += 40;
            lbl_player3.frame.origin.y += 40;
            lbl_player4.frame.origin.y += 40;
            lbl_player5.frame.origin.y += 40;
            lbl_player_lvl_1.frame.origin.y += 40;
            lbl_player_lvl_2.frame.origin.y += 40;
            lbl_player_lvl_3.frame.origin.y += 40;
            lbl_player_lvl_4.frame.origin.y += 40;
            lbl_player_lvl_5.frame.origin.y += 40;
            bar_player1.frame.origin.y += 40;
            bar_player2.frame.origin.y += 40;
            bar_player3.frame.origin.y += 40;
            bar_player4.frame.origin.y += 40;
            bar_player5.frame.origin.y += 40;
            
            
            
            btn_EnterGame.frame.origin.x -= 20;
            lbl_GameID.frame.origin.x -= 20;
            lbl_player1.frame.origin.x -= 20;
            lbl_player2.frame.origin.x -= 20;
            lbl_player3.frame.origin.x -= 20;
            lbl_player4.frame.origin.x -= 20;
            lbl_player5.frame.origin.x -= 20;
            lbl_player_lvl_1.frame.origin.x -= 20;
            lbl_player_lvl_2.frame.origin.x -= 20;
            lbl_player_lvl_3.frame.origin.x -= 20;
            lbl_player_lvl_4.frame.origin.x -= 20;
            lbl_player_lvl_5.frame.origin.x -= 20;
            bar_player1.frame.origin.x -= 20;
            bar_player2.frame.origin.x -= 20;
            bar_player3.frame.origin.x -= 20;
            bar_player4.frame.origin.x -= 20;
            bar_player5.frame.origin.x -= 20;
            btn_profile.frame.origin.x -= 34;
            btn_back.frame.origin.y += 18;
            btn_profile.frame.origin.y += 18;
        }
        else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s"){
            
            background.frame.size = self.view.frame.size;
            btn_EnterGame.frame.origin.y -= 30;
            lbl_GameID.frame.origin.y -= 30;
            lbl_player1.frame.origin.y  -= 30;
            lbl_player2.frame.origin.y  -= 30;
            lbl_player3.frame.origin.y  -= 30;
            lbl_player4.frame.origin.y  -= 30;
            lbl_player5.frame.origin.y -= 30;
            lbl_player_lvl_1.frame.origin.y -= 30;
            lbl_player_lvl_2.frame.origin.y -= 30;
            lbl_player_lvl_3.frame.origin.y -= 30;
            lbl_player_lvl_4.frame.origin.y -= 30;
            lbl_player_lvl_5.frame.origin.y -= 30;
            bar_player1.frame.origin.y -= 30;
            bar_player2.frame.origin.y -= 30;
            bar_player3.frame.origin.y -= 30;
            bar_player4.frame.origin.y -= 30;
            bar_player5.frame.origin.y -= 30;
            
            
            
            btn_EnterGame.frame.origin.x -= 20;
            lbl_GameID.frame.origin.x -= 20;
            lbl_player1.frame.origin.x -= 20;
            lbl_player2.frame.origin.x -= 20;
            lbl_player3.frame.origin.x -= 20;
            lbl_player4.frame.origin.x -= 20;
            lbl_player5.frame.origin.x -= 20;
            lbl_player_lvl_1.frame.origin.x -= 20;
            lbl_player_lvl_2.frame.origin.x -= 20;
            lbl_player_lvl_3.frame.origin.x -= 20;
            lbl_player_lvl_4.frame.origin.x -= 20;
            lbl_player_lvl_5.frame.origin.x -= 20;
            bar_player1.frame.origin.x -= 20;
            bar_player2.frame.origin.x -= 20;
            bar_player3.frame.origin.x -= 20;
            bar_player4.frame.origin.x -= 20;
            bar_player5.frame.origin.x -= 20;
            btn_profile.frame.origin.x -= 34;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
    }
    
    override func viewDidLoad() {
        
        ui = UI (size: self.view.frame.size);
        
        adjustUI()
        
        
        if (gamecode != nil){
            lbl_GameID.text = gamecode;
            UserDefaults.standard.setValue(self.gamecode, forKey: "MP_GAME_ID")
        }
        
        lbl_player1.text = MP_PLAYER_NICKNAME;
        lbl_player_lvl_1.text = "Lvl " + MP_PLAYER_LEVEL;
        
        if (room.get_NumberOfPlayers() < 2){
            btn_EnterGame.isEnabled = false;
        }
        else{
            btn_EnterGame.isEnabled = true;
        }
    }
    
    func add_handlers(){
        SC.socket.on("newplayer") {data, ack in
            let nickname = data[0] as? String
            print("New player joined to game with nickname: '" + (nickname ?? "ERROR LOADING THE PLAYER NICKNAME") + "'");
            
            //Move to game group screen
            //send to a function that update the names of the players in the game to ui table.
            //data has the name of the player
        }
        SC.socket.on("opengame") {data, ack in
            
            print("Open game")
            self.performSegue(withIdentifier: "segue_opengame", sender: self)
        }
    }
    
    @IBAction func btn_EnterGame(_ sender: Any) {
        if (room.get_NumberOfPlayers() >= 2){
            SC.openGame(gameID: lbl_GameID.text!);
            SC.socket.on("opengame") {data, ack in

                
                self.performSegue(withIdentifier: "segue_opengame", sender: self)
            }
        }
    }
    
    func updatePlayersList(){
        hidePlayerList();
        var i = 0;
        for player in room.players{
            if (i != 0){
                setPlayer_Fields(index: i, nickname: player.get_Nickname(), lvl: player.get_Level())
            }
            
            i += 1;
        }
        
        if (room.get_NumberOfPlayers() < 2){
            btn_EnterGame.isEnabled = false;
        }
        else{
            btn_EnterGame.isEnabled = true;
        }
    }
    
    func hidePlayerList(){
        lbl_player2.isHidden = true;
        lbl_player_lvl_2.isHidden = true;
        bar_player2.isHidden = true;
        lbl_player3.isHidden = true;
        lbl_player_lvl_3.isHidden = true;
        bar_player3.isHidden = true;
        lbl_player4.isHidden = true;
        lbl_player_lvl_4.isHidden = true;
        bar_player4.isHidden = true;
        lbl_player5.isHidden = true;
        lbl_player_lvl_5.isHidden = true;
        bar_player5.isHidden = true;
    }
    
    func setPlayer_Fields(index: Int, nickname: String, lvl: String){
        switch (index + 1) {
        case 2:
            lbl_player2.text = nickname;
            lbl_player_lvl_2.text = "Lvl " + lvl;
            lbl_player2.isHidden = false;
            lbl_player_lvl_2.isHidden = false;
            bar_player2.isHidden = false;
            break;
        case 3:
            lbl_player3.text = nickname;
            lbl_player_lvl_3.text = "Lvl " + lvl;
            lbl_player3.isHidden = false;
            lbl_player_lvl_3.isHidden = false;
            bar_player3.isHidden = false;
            break;
        case 4:
            lbl_player4.text = nickname;
            lbl_player_lvl_4.text = "Lvl " + lvl;
            lbl_player4.isHidden = false;
            lbl_player_lvl_4.isHidden = false;
            bar_player4.isHidden = false;
            break;
        case 5:
            lbl_player5.text = nickname;
            lbl_player_lvl_5.text = "Lvl " + lvl;
            lbl_player5.isHidden = false;
            lbl_player_lvl_5.isHidden = false;
            bar_player5.isHidden = false;
            break;
        default:
            break;
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        if (room.get_NumberOfPlayers() == 1){
            
            // create the alert
            let alert = UIAlertController(title: "Close room?", message: "Are you sure you want to close room?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.destructive) { (alertAction) in
                self.SC.endGame(gameID: self.gamecode);
                
               UserDefaults.standard.removeObject(forKey: "MP_GAME_ID")
               UserDefaults.standard.removeObject(forKey: "MP_PLAYER_ID")
                
                room = nil;
                
                self.dismissViewController()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "exitGroupList"), object: nil)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) in })
            
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else{
        
            // create the alert
            let alert = UIAlertController(title: "Leave room?", message: "Are you sure you want to leave room?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Leave", style: UIAlertAction.Style.destructive) { (alertAction) in
                self.SC.userExit(playerID: self.playerID, gameID: self.gamecode)
            
                UserDefaults.standard.removeObject(forKey: "MP_GAME_ID")
                UserDefaults.standard.removeObject(forKey: "MP_PLAYER_ID")
                
                room = nil;
                
                self.dismissViewController()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "exitGroupList"), object: nil)
            })
            
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) in })

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_opengame" {
            if let game = segue.destination as? VC_MP_Game {
                game.SC = SC;
                game.gamecode = lbl_GameID.text!;
                game.playerID = self.playerID;
                game.level_status = UserDefaults.standard.float(forKey: "PLAYER_LEVEL_STATUS")
            }
        }
    }
}
