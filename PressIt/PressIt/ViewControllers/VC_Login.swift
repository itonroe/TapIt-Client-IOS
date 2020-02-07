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
    
    let SC = ServerConversation();
    
    @IBOutlet weak var txt_Username: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    override func viewDidLoad() {
        
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
                    
                    UserDefaults.standard.set("true", forKey: "SIGN_IN")
                    UserDefaults.standard.set(self.txt_Username.text, forKey: "PLAYER_NICKNAME")
                    UserDefaults.standard.set(data[0] as! String, forKey: "PLAYER_LEVEL")
                    UserDefaults.standard.set(data[1] as! String, forKey: "PLAYER_LEVEL_STATUS")
                    
                    self.performSegue(withIdentifier: "segue_mp_menu", sender: self)
                }
            }
        }
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
