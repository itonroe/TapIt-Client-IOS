//
//  VC_Login.swift
//  PressIt
//
//  Created by Roe Iton on 24/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_Login: UIViewController {
    
    var ui: UI!;
    
    let SC = ServerConversation();
    
    @IBOutlet weak var txt_Username: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_guest: UIButton!
    @IBOutlet weak var btn_signup: UIButton!
    @IBOutlet weak var lbl_signup: UILabel!
    @IBOutlet weak var bar_left: UIImageView!
    @IBOutlet weak var bar_right: UIImageView!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var lbl_or: UILabel!
    @IBOutlet weak var lbl_forgot: UIButton!
    
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            
            txt_Username.frame.origin.y += 120;
            txt_Password.frame.origin.y += 120;
            btn_login.frame.origin.y += 120;
            btn_guest.frame.origin.y += 120;
            btn_signup.frame.origin.y += 160;
            bar_left.frame.origin.y += 120;
            bar_right.frame.origin.y += 120;
            lbl_or.frame.origin.y += 120;
            lbl_forgot.frame.origin.y += 120;
            lbl_signup.frame.origin.y += 160;
            btn_back.frame.origin.y += 18;
            
        }
        else if (UIDevice.modelName == "iPhone 11 Pro"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            
            txt_Username.frame.origin.x -= 20;
            txt_Password.frame.origin.x -= 20;
            btn_login.frame.origin.x -= 20;
            btn_guest.frame.origin.x -= 20;
            btn_signup.frame.origin.x -= 20;
            bar_left.frame.origin.x -= 20;
            bar_right.frame.origin.x -= 20;
            lbl_or.frame.origin.x -= 20;
            lbl_forgot.frame.origin.x -= 20;
            lbl_signup.frame.origin.x -= 20;
            
            txt_Username.frame.origin.y += 40;
            txt_Password.frame.origin.y += 40;
            btn_login.frame.origin.y += 40;
            btn_guest.frame.origin.y += 40;
            btn_signup.frame.origin.y += 70;
            bar_left.frame.origin.y += 40;
            bar_right.frame.origin.y += 40;
            lbl_or.frame.origin.y += 40;
            lbl_forgot.frame.origin.y += 40;
            lbl_signup.frame.origin.y += 70;
            
            btn_back.frame.origin.y += 18;
            
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        
        
        //img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        //btn_Classic.frame.origin = ui.getNewLocation(old_location: btn_Classic.frame.origin)
        //btn_Multiplayer.frame.origin = ui.getNewLocation(old_location: btn_Multiplayer.frame.origin)
        //btn_Sound.frame.origin = ui.getNewLocation(old_location: btn_Sound.frame.origin)
        //lbl_Copyright.frame.origin = ui.getNewLocation(old_location: lbl_Copyright.frame.origin)
        
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        //background.frame.size = ui.getNewSize(old_size: background.frame.size)
        //btn_Classic.frame.size = ui.getNewSize(old_size: btn_Classic.frame.size)
        //btn_Multiplayer.frame.size = ui.getNewSize(old_size: btn_Multiplayer.frame.size)
        //btn_Sound.frame.size = ui.getNewSize(old_size: btn_Sound.frame.size)
        //lbl_Copyright.frame.size = ui.getNewSize(old_size: lbl_Copyright.frame.size)
    }
    
    override func viewDidLoad() {
        ui = UI (size: self.view.frame.size);
        adjustUI();
        self.hideKeyboardWhenTappedAround()
        txt_Username.attributedPlaceholder = NSAttributedString(string: "Username",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        txt_Password.attributedPlaceholder = NSAttributedString(string: "Password",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        txt_Username.setIcon(image: UIImage(named: "user_ico.png")!)
        txt_Password.setIcon(image: UIImage(named: "password_ico.png")!)
        txt_Username.useUnderline();
        txt_Password.useUnderline();
        //txt_Username.setBorder(width: 1, color: UIColor.systemRed)
        //txt_Username.setLeftPaddingPoints(20);
        //txt_Password.setLeftPaddingPoints(20);
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
    
    @IBAction func btn_login(_ sender: Any) {
        if (checkValidation()){
            SC.socket.emit("login", [txt_Username.text, txt_Password.text]);
            
            SC.socket.on("login") {data, ack in
                if (data.count <= 1){
                    self.openAlertError(title: "Login Failed", message: "Username or password is incorrect.")
                }
                else {
                    print("Login Successfully");

                    MP_PLAYER_NICKNAME = self.txt_Username.text!
                    MP_PLAYER_LEVEL = data[0] as! String
                    MP_PLAYER_LEVEL_STATUS = data[1] as! String
                    
                    self.updateProfileDefaults();
                    
                    self.performSegue(withIdentifier: "segue_mp_menu", sender: self)
                }
            }
        }
    }
    
    func updateProfileDefaults(){
        updateUserDefaults(key: "SIGN_IN", value: "true")
        updateUserDefaults(key: "PLAYER_NICKNAME", value: MP_PLAYER_NICKNAME)
        updateUserDefaults(key: "PLAYER_LEVEL", value: MP_PLAYER_LEVEL)
        updateUserDefaults(key: "PLAYER_LEVEL_STATUS", value: MP_PLAYER_LEVEL_STATUS)
    }
    
    func checkValidation() -> Bool{
        if (txt_Username.text == "" || txt_Password.text == ""){ return false}
        
        return true;
    }
    
    @IBAction func btn_signup(_ sender: Any) {
        performSegue(withIdentifier: "segue_signup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_signup"){
            if let signup = segue.destination as? VC_Signup {
                signup.SC = SC;
            }
        }
    }
    
}
