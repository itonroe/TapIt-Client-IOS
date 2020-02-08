//
//  VC_MP_Profile.swift
//  PressIt
//
//  Created by Roe Iton on 08/02/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_MP_Profile: UIViewController {
    
    @IBOutlet weak var lbl_Nickname: UILabel!
    @IBOutlet weak var lbl_Level: UILabel!
    @IBOutlet weak var lbl_Level_Status: UILabel!
    @IBOutlet weak var btn_Logout: UIButton!
    @IBOutlet weak var circularProgress: CircularProgressView!
    
    var onDoneBlock : ((Bool) -> Void)?
    
    override func viewDidLoad() {
        lbl_Nickname.text = MP_PLAYER_NICKNAME;
        lbl_Level.text = MP_PLAYER_LEVEL;
        lbl_Level_Status.text = String(Int(getPrecentOfLevel() * 100)) + "%";
        
        circularProgress.progressClr = UIColor.white
        circularProgress.trackClr = UIColor.init(red: 184, green: 244, blue: 199, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        circularProgress.setProgressWithAnimation(duration: 1.0, value: getPrecentOfLevel());
    }
    
    func getPrecentOfLevel() -> Float{
        let precent = UserDefaults.standard.float(forKey: "PLAYER_LEVEL_STATUS") / Float(getCountToNextLevel());
        
        return precent;
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
    
    @IBAction func btn_Logout(_ sender: Any) {
        //onDoneBlock!(true)
        
        //Need to do when logout reset username to guest and etc.
        
        UserDefaults.standard.set(false, forKey: "SIGN_IN")
        UserDefaults.standard.set("Guest", forKey: "PLAYER_NICKNAME")
        UserDefaults.standard.set("1", forKey: "PLAYER_LEVEL")
        UserDefaults.standard.set("39.0", forKey: "PLAYER_LEVEL_STATUS")
        
        SIGNEDIN = UserDefaults.standard.bool(forKey: "SIGN_IN");
        MP_PLAYER_NICKNAME = UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") as! String;
        MP_PLAYER_LEVEL = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as! String;
        print(UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as! String);
        MP_PLAYER_LEVEL_STATUS = UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as! String;
        
        dismissViewController()
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        dismissViewController();
    }
    
    func updateLabelsValues(){
        if (SIGNEDIN){
            lbl_Nickname.text = MP_PLAYER_NICKNAME;
            lbl_Level.text = MP_PLAYER_LEVEL;
            lbl_Level_Status.text = MP_PLAYER_LEVEL_STATUS;
        }
    }
}
