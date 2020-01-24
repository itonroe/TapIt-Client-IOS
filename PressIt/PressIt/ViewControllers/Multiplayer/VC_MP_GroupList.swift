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

class VC_MP_GroupList: UIViewController {
    
    var SC: ServerConversation!
    var room: Room!
    
    var isHost: Bool!
    
    @IBOutlet weak var btn_EnterGame: UIButton!
    @IBOutlet weak var lbl_GameID: UILabel!
    
    var gamecode: String!
    var nickname: String!
    var playerID: String!
    var lvl_status: String!
    var level: String!
    
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
    
    
    override func viewDidLoad() {
        if (gamecode != nil){
                lbl_GameID.text = gamecode;
        }
        
        if (room == nil){
            room = Room(nickname: nickname, lvl: level, roomID: gamecode, playerID: playerID);}
        
        lbl_player1.text = nickname;
        lbl_player_lvl_1.text = level;
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
        if (room.get_NumberOfPlayers() > 0){
            SC.openGame(gameID: lbl_GameID.text!);
            SC.socket.on("opengame") {data, ack in

                print("Open game")
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

                let transition: CATransition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                self.view.window!.layer.add(transition, forKey: nil)
                self.dismiss(animated: false, completion: nil)
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

                let transition: CATransition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                self.view.window!.layer.add(transition, forKey: nil)
                self.dismiss(animated: false, completion: nil)
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
                game.level_status = UserDefaults.standard.float(forKey: "PLAYER_LEVEL_STATUS")
                game.level = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as? String;
            }
        }
    }
}
