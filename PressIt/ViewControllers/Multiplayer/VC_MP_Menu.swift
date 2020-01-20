//
//  VC_MP_Menu.swift
//  PressIt
//
//  Created by Roe Iton on 23/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_MP_Menu: UIViewController{
    
    var ui: UI!
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btn_Host: UIButton!
    @IBOutlet weak var btn_Join: UIButton!
    
    var SC = ServerConversation()
    var gameID: String!
    var nickname: String!
    var playerID: String!
    var lvl: String!
    var lvl_status: String!
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            btn_Join.frame.origin.y -= 12;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            btn_Join.frame.origin.y -= 6;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        btn_Host.frame.origin = ui.getNewLocation(old_location: btn_Host.frame.origin)
        btn_Join.frame.origin = ui.getNewLocation(old_location: btn_Join.frame.origin)
        
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        background.frame.size = ui.getNewSize(old_size: background.frame.size)
        btn_Host.frame.size = ui.getNewSize(old_size: btn_Host.frame.size)
        btn_Join.frame.size = ui.getNewSize(old_size: btn_Join.frame.size)
    }
    
    override func viewDidLoad() {
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        if (UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") != nil){
            self.nickname = UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") as? String;
            self.lvl = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as? String;
            self.lvl_status = UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as? String;
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_Host(_ sender: Any) {
        SC.createNewGame(nickname: nickname, lvl: lvl)
        
        SC.socket.on("newgame") {data, ack in
            self.gameID = data[0] as? String
            self.playerID = data[1] as? String
            //print("New player joined to game with nickname: '" + (nickname ?? "ERROR LOADING THE PLAYER NICKNAME") + "'");
            self.performSegue(withIdentifier: "segue_createroom", sender: self)
            
            //Move to game group screen
            //send to a function that update the names of the players in the game to ui table.
            //data has the name of the player
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_createroom" {
            if let groupList = segue.destination as? VC_MP_GroupList {
                groupList.isHost = true;
                groupList.gamecode = self.gameID;
                groupList.nickname = self.nickname;
                groupList.lvl_status = self.lvl_status;
                
                
                groupList.room = Room(nickname: nickname, lvl: lvl, roomID: gameID, playerID: playerID)
                SC.viewController = groupList;
                //SC.getallplayers(gameID: gameID)
                
                
                groupList.playerID = self.playerID;
                groupList.SC = SC;
                groupList.add_handlers();
            }
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
