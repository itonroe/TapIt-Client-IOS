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
    
    var ui: UI!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var lbl_Nickname: UILabel!
    @IBOutlet weak var lbl_Level: UILabel!
    @IBOutlet weak var lbl_Level_Status: UILabel!
    @IBOutlet weak var btn_Logout: UIButton!
    @IBOutlet weak var circularProgress: CircularProgressView!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var lbl_Level_Text: UILabel!
    
    var hideLogout = true;
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
         
            lbl_Nickname.frame.origin.y += 100;
            btn_Logout.frame.origin.y += 100;
            circularProgress.frame.origin.y += 100;
            btn_Back.frame.origin.y += 18;
            
        }
        else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            
            
            
            lbl_Nickname.frame.origin.y += 40;
            btn_Logout.frame.origin.y += 100;
            circularProgress.frame.origin.y += 40;
            
            
            lbl_Nickname.frame.origin.x -= 22;
            lbl_Level_Text.frame.origin.x -= 1;
            //lbl_Level.frame.origin.x -= 20;
            //lbl_Level_Status.frame.origin.x -= 20;
            btn_Logout.frame.origin.x -= 20;
            circularProgress.frame.origin.x -= 20;
            
            btn_Back.frame.origin.y += 18;
        }else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s" || UIDevice.isModelaniPad()){
                background.frame.size = self.view.frame.size;

                lbl_Nickname.frame.origin.y -= 30;
            btn_Logout.frame.origin.y -= 30;
                circularProgress.frame.origin.y -= 30;
            
                lbl_Nickname.frame.origin.x -= 22;
                lbl_Level_Text.frame.origin.x -= 1;
                //lbl_Level.frame.origin.x -= 20;
                //lbl_Level_Status.frame.origin.x -= 20;
                btn_Logout.frame.origin.x -= 20;
                circularProgress.frame.origin.x -= 20;
        }
        else{
        }
        
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        
        
        
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
    }
    
    override func viewDidLoad() {
        lbl_Nickname.text = MP_PLAYER_NICKNAME;
        lbl_Level.text = MP_PLAYER_LEVEL;
        lbl_Level_Status.text = String(Int(getPrecentOfLevel() * 100)) + "%";
        
        circularProgress.progressClr = UIColor.white
        circularProgress.trackClr = UIColor.init(red: 184, green: 244, blue: 199, alpha: 1)
        
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        btn_Logout.isHidden = hideLogout;
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
        
        // create the alert
        let alert = UIAlertController(title: "Log out?", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertAction.Style.destructive) { (alertAction) in
        
            UserDefaults.standard.set(false, forKey: "SIGN_IN")
            UserDefaults.standard.set("Guest", forKey: "PLAYER_NICKNAME")
            UserDefaults.standard.set("1", forKey: "PLAYER_LEVEL")
            UserDefaults.standard.set("0.0", forKey: "PLAYER_LEVEL_STATUS")
            
            SIGNEDIN = UserDefaults.standard.bool(forKey: "SIGN_IN");
            MP_PLAYER_NICKNAME = UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") as! String;
            MP_PLAYER_LEVEL = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as! String;
            MP_PLAYER_LEVEL_STATUS = UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as! String;
            
            self.dismissViewController()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "exitProfile"), object: nil)
        })
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) in })

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        dismissViewController();
    }
    
    func updateLabelsValues(){
        if (SIGNEDIN){
            lbl_Nickname.text = MP_PLAYER_NICKNAME;
            lbl_Level.text = MP_PLAYER_LEVEL;
            lbl_Level_Status.text = MP_PLAYER_LEVEL_STATUS;
            
            btn_Logout.isHidden = false;
        }
    }
}
