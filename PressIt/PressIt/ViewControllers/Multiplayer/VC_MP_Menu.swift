//
//  VC_MP_Menu.swift
//  PressIt
//
//  Created by Roe Iton on 23/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

//Define here the serverconnection

class VC_MP_Menu: UIViewController{
    
    var ui: UI!
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btn_Host: UIButton!
    @IBOutlet weak var btn_Join: UIButton!
    @IBOutlet weak var lbl_Useranme: UILabel!
    
    var SC = ServerConversation()
    var gameID: String!
    var playerID: String!
    
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
        
        
        lbl_Useranme.text = MP_PLAYER_NICKNAME;
    }
    
    @IBAction func btn_Host(_ sender: Any) {
        SC.createNewGame(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL)
        
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
                //groupList.nickname = MP_PLAYER_NICKNAME;
                //groupList.level = MP_PLAYER_LEVEL;
                //groupList.lvl_status = self.lvl_status;
                
                
                groupList.room = Room(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL, roomID: gameID, playerID: playerID)
                SC.viewController = groupList;
                //SC.getallplayers(gameID: gameID)
                
                
                groupList.playerID = self.playerID;
                groupList.SC = SC;
                groupList.add_handlers();
            }
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
}
