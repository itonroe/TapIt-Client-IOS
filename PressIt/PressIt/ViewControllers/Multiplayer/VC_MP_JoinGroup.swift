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
    
    var ui: UI!
    @IBOutlet weak var txt_gamecode: UITextField!
    
    let SC = ServerConversation();
    var playerID: String!
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btn_join: UIButton!
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            btn_join.frame.origin.y -= 12;
            btn_back.frame.origin.y += 18;
            btn_profile.frame.origin.y += 18;
            //txt_gamecode.frame.origin.x -= 4;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            btn_join.frame.origin.y -= 6;
            
            txt_gamecode.frame.origin.x -= 4;
            btn_join.frame.origin.x -= 4;
            btn_profile.frame.origin.x -= 34;
            btn_back.frame.origin.y += 18;
            btn_profile.frame.origin.y += 18;
            
            //btn_Host.frame.origin.x = btn_Host.frame.origin.x - 10;
            //btn_Join.frame.origin.x = btn_Join.frame.origin.x - 10;
            //lbl_Useranme.frame.origin.x = lbl_Useranme.frame.origin.x - 10;
            }else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s" || UIDevice.isModelaniPad()){
                    background.frame.size = self.view.frame.size;
                    btn_profile.frame.origin.x -= 34;
            
                    btn_join.frame.origin.y += 4;
                    btn_join.frame.origin.x -= 12;
                    txt_gamecode.frame.origin.x -= 12;
            }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        txt_gamecode.frame.origin = ui.getNewLocation(old_location: txt_gamecode.frame.origin)
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        btn_join.frame.origin = ui.getNewLocation(old_location: btn_join.frame.origin)
        
        //txt_gamecode.frame.size = ui.getNewSize(old_size: txt_gamecode.frame.size)
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        //background.frame.size = ui.getNewSize(old_size: background.frame.size)
        //btn_join.frame.size = ui.getNewSize(old_size: btn_join.frame.size)
    }
    
    override func viewDidLoad() {
        
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitGroupList(notification:)), name: Notification.Name("exitGroupList"), object: nil)
        
        self.hideKeyboardWhenTappedAround()
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.value(forKey: "MP_GAME_ID") != nil){
            let gameID = UserDefaults.standard.value(forKey: "MP_GAME_ID") as! String

            txt_gamecode.text = gameID;
            txt_gamecode.isEnabled = false;
            txt_gamecode.backgroundColor = UIColor.lightGray

        }
    }
    
    func exitExistingUser(){
        if (UserDefaults.standard.value(forKey: "MP_GAME_ID") != nil){
            let gameID = UserDefaults.standard.value(forKey: "MP_GAME_ID") as! String
            let prev_Player_ID = UserDefaults.standard.value(forKey: "MP_PLAYER_ID") as! String;

            SC.userExit(playerID: prev_Player_ID, gameID: gameID);

            
            UserDefaults.standard.removeObject(forKey: "MP_GAME_ID")
            UserDefaults.standard.removeObject(forKey: "MP_PLAYER_ID")
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        exitExistingUser()
        dismissViewController();
    }
    
    @IBAction func btn_Join(_ sender: Any) {
        
        if(txt_gamecode.text == ""){
            return;
        }
        
        exitExistingUser()
        
        SC.addNewPlayer(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL, gameID: txt_gamecode.text!)
        
        SC.socket.on("newplayer") {data, ack in
            if (data[0] as? String == "-1"){
                self.openAlertError(title: "Oops!", message: "Game '" + self.txt_gamecode.text! + "' isn't exists.")
                return;
            }
            else if (data[0] as? String == "-2"){
                self.openAlertError(title: "Oops!", message: "Game '" + self.txt_gamecode.text! + "' is full.")
                return;
            }
            
            self.playerID = data[1] as? String
            UserDefaults.standard.setValue(self.playerID, forKey: "MP_PLAYER_ID")
            //print("New player joined to game with nickname: '" + (MP_PLAYER_NICKNAME ?? "ERROR LOADING THE PLAYER NICKNAME") + "'");
            self.performSegue(withIdentifier: "segue_openroom", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_openroom" {
            if let groupList = segue.destination as? VC_MP_GroupList {
                
                groupList.isHost = false;
                groupList.gamecode = txt_gamecode.text;
                groupList.playerID = self.playerID;
                
                room = Room(nickname: MP_PLAYER_NICKNAME, lvl: MP_PLAYER_LEVEL, roomID: txt_gamecode.text!, playerID: playerID)
                SC.viewController = groupList;
                
                SC.getallplayers(gameID: txt_gamecode.text!)
                
                groupList.SC = SC;
                groupList.add_handlers();
            }
        }
    }
    
    @objc func exitGroupList(notification: NSNotification){
        self.view.removeFromSuperview()
        self.removeFromParent()
        self.dismiss(animated: false, completion: nil)
    }
}
