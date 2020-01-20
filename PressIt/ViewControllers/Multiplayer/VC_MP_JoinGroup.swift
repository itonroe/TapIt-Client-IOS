//
//  VC_MP_JoinGroup.swift
//  PressIt
//
//  Created by Roe Iton on 21/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit
import SocketIO

class VC_MP_JoinGroup: UIViewController {
    
    @IBOutlet weak var txt_gamecode: UITextField!
    
    let SC = ServerConversation();
    var nickname: String!
    var lvl: String!
    var playerID: String!
    
    override func viewDidLoad() {
        if (UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") != nil){
            self.nickname = UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") as? String;
            self.lvl = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as? String;
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func btn_Join(_ sender: Any) {
        
        SC.addNewPlayer(nickname: nickname, lvl: lvl, gameID: txt_gamecode.text!)
        
        SC.socket.on("newplayer") {data, ack in
            let nickname = data[0] as? String
            self.playerID = data[1] as? String
            print("New player joined to game with nickname: '" + (nickname ?? "ERROR LOADING THE PLAYER NICKNAME") + "'");
            self.performSegue(withIdentifier: "segue_openroom", sender: self)
            
            //Move to game group screen
            //send to a function that update the names of the players in the game to ui table.
            //data has the name of the player
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_openroom" {
            if let groupList = segue.destination as? VC_MP_GroupList {
                
                groupList.isHost = false;
                groupList.gamecode = txt_gamecode.text;
                groupList.nickname = self.nickname;
                groupList.playerID = self.playerID;
                
                groupList.room = Room(nickname: nickname, lvl: lvl, roomID: txt_gamecode.text!, playerID: playerID)
                SC.viewController = groupList;
                SC.getallplayers(gameID: txt_gamecode.text!)
                
                groupList.SC = SC;
                groupList.add_handlers();
            }
        }
    }
}
