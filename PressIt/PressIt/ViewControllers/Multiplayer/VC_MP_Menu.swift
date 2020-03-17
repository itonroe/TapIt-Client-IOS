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
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    
    var SC = ServerConversation()
    var gameID: String!
    var playerID: String!
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            btn_Join.frame.origin.y -= 12;
            lbl_Useranme.frame.origin.x -= 4;
            btn_back.frame.origin.y += 18;
            btn_profile.frame.origin.y += 18;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            btn_Join.frame.origin.y -= 6;
            btn_Join.frame.origin.x -= 6;
            btn_Host.frame.origin.x -= 6;
            lbl_Useranme.frame.origin.x -= 6;
            btn_profile.frame.origin.x -= 34;
            btn_back.frame.origin.y += 18;
            btn_profile.frame.origin.y += 18;
            
            //btn_Host.frame.origin.x = btn_Host.frame.origin.x - 10;
            //btn_Join.frame.origin.x = btn_Join.frame.origin.x - 10;
            //lbl_Useranme.frame.origin.x = lbl_Useranme.frame.origin.x - 10;
        }else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s" || UIDevice.isModelaniPad()){
            background.frame.size = self.view.frame.size;
            
            btn_Join.frame.origin.y += 4;
            btn_Join.frame.origin.x -= 12;
            btn_Host.frame.origin.x -= 12;
            lbl_Useranme.frame.origin.x -= 12;
            btn_profile.frame.origin.x -= 34;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        lbl_Useranme.frame.origin = ui.getNewLocation(old_location: lbl_Useranme.frame.origin)
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        btn_Host.frame.origin = ui.getNewLocation(old_location: btn_Host.frame.origin)
        btn_Join.frame.origin = ui.getNewLocation(old_location: btn_Join.frame.origin)
        
        //lbl_Useranme.frame.size = ui.getNewSize(old_size: lbl_Useranme.frame.size)
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        //btn_Host.frame.size = ui.getNewSize(old_size: btn_Host.frame.size)
        //btn_Join.frame.size = ui.getNewSize(old_size: btn_Join.frame.size)
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(exitProfile(notification:)), name: Notification.Name("exitProfile"), object: nil)
        
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        
        lbl_Useranme.text = MP_PLAYER_NICKNAME;
        
        if (UserDefaults.standard.value(forKey: "MP_GAME_ID") != nil){
            performSegue(withIdentifier: "segue_join", sender: self)
        }
        
        
    }
    
    @IBAction func btn_Host(_ sender: Any) {
        SC.createNewGame(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL)
        
        SC.socket.on("newgame") {data, ack in
            self.gameID = data[0] as? String
            self.playerID = data[1] as? String
            UserDefaults.standard.setValue(self.playerID, forKey: "MP_PLAYER_ID")
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
                
                
                room = Room(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL, roomID: gameID, playerID: playerID)
                SC.viewController = groupList;
                SC.getallplayers(gameID: gameID)
                
                
                groupList.playerID = self.playerID;
                UserDefaults.standard.setValue(playerID, forKey: "MP_PLAYER_ID")
                groupList.SC = SC;
                groupList.add_handlers();
            }
        }
        else if segue.identifier == "segue_profile" {
            if let profile = segue.destination as? VC_MP_Profile {
                if(SIGNEDIN){
                    profile.hideLogout = false;
                }
            }
        }
    }
    
    @IBAction func btn_Profile(_ sender: Any) {
        performSegue(withIdentifier: "segue_profile", sender: self)
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
    
    @objc func exitProfile(notification: NSNotification){
        print("User logged out.")
        
        
        lbl_Useranme.text = MP_PLAYER_NICKNAME;
        
    }
}
