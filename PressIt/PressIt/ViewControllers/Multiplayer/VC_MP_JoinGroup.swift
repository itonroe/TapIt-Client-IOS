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
    var playerID: String!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        dismissViewController();
    }
    
    @IBAction func btn_Join(_ sender: Any) {
        
        SC.addNewPlayer(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL, gameID: txt_gamecode.text!)
        
        SC.socket.on("newplayer") {data, ack in
            let nickname = data[0] as? String
            self.playerID = data[1] as? String
            print("New player joined to game with nickname: '" + (nickname ?? "ERROR LOADING THE PLAYER NICKNAME") + "'");
            self.performSegue(withIdentifier: "segue_openroom", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_openroom" {
            if let groupList = segue.destination as? VC_MP_GroupList {
                
                groupList.isHost = false;
                groupList.gamecode = txt_gamecode.text;
                groupList.playerID = self.playerID;
                
                groupList.room = Room(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL, roomID: txt_gamecode.text!, playerID: playerID)
                SC.viewController = groupList;
                SC.getallplayers(gameID: txt_gamecode.text!)
                
                groupList.SC = SC;
                groupList.add_handlers();
            }
        }
    }
}
