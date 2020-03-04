//
//  VC_Signup.swift
//  PressIt
//
//  Created by Roe Iton on 31/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_Signup: UIViewController {
    var ui: UI!
    var SC: ServerConversation!;
    @IBOutlet weak var txt_Username: UITextField!
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var txt_Password: UITextField!
       @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var btn_signup: UIButton!
    
    @IBOutlet weak var lbl_Error: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var lbl_login: UILabel!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    
    let ERR_USERNAME_VALID = "Username must be alphanumeric and between 4 to 12 characters";
    let ERR_USERNAME_TAKEN = "Username is already taken";
    let ERR_PASSWORD = "Password must be at least 8 characters";
    let ERR_EMAIL_VALID = "Email is not valid";
    let ERR_EMAIL_TAKEN = "Email is already taken";
       
    func adjustUI(){
        if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            
            txt_Username.frame.origin.y += 120;
            txt_Password.frame.origin.y += 120;
            txt_Email.frame.origin.y += 120;
            lbl_Error.frame.origin.y += 120;
            btn_signup.frame.origin.y += 160;
            btn_login.frame.origin.y += 160;
            lbl_login.frame.origin.y += 160;
            btn_back.frame.origin.y += 18;
            
        }
        else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            
            txt_Username.frame.origin.x -= 20;
            txt_Password.frame.origin.x -= 20;
            btn_login.frame.origin.x -= 20;
            txt_Email.frame.origin.x -= 20;
            btn_signup.frame.origin.x -= 20;
            lbl_Error.frame.origin.x -= 20;
            lbl_login.frame.origin.x -= 20;

            
            txt_Username.frame.origin.y += 40;
            txt_Password.frame.origin.y += 40;
            txt_Email.frame.origin.y += 40;
            lbl_Error.frame.origin.y += 40;
            btn_signup.frame.origin.y += 70;
            btn_login.frame.origin.y += 70;
            lbl_login.frame.origin.y += 70;
            
            
            btn_back.frame.origin.y += 18;
        }
        else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s"){
           background.frame.size = self.view.frame.size;
           txt_Username.frame.origin.x -= 20;
           txt_Password.frame.origin.x -= 20;
           btn_login.frame.origin.x -= 20;
           txt_Email.frame.origin.x -= 20;
           btn_signup.frame.origin.x -= 20;
           lbl_Error.frame.origin.x -= 20;
           lbl_login.frame.origin.x -= 20;

            txt_Username.frame.origin.y -= 30;
           txt_Password.frame.origin.y -= 30;
           txt_Email.frame.origin.y -= 30;
           lbl_Error.frame.origin.y -= 30;
           btn_signup.frame.origin.y -= 60;
           btn_login.frame.origin.y -= 60;
           lbl_login.frame.origin.y -= 60;
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

        adjustUI()
           self.hideKeyboardWhenTappedAround()
           txt_Username.useUnderline();
           txt_Email.useUnderline();
           txt_Password.useUnderline();
           txt_Username.attributedPlaceholder = NSAttributedString(string: "Username",
                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
           txt_Password.attributedPlaceholder = NSAttributedString(string: "Password",
                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        txt_Email.attributedPlaceholder = NSAttributedString(string: "Email",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
           txt_Username.setIcon(image: UIImage(named: "user_ico.png")!)
           txt_Password.setIcon(image: UIImage(named: "password_ico.png")!)
        txt_Email.setIcon(image: UIImage(named: "email_ico.png")!)
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
    
    
    @IBAction func btn_Signup(_ sender: Any) {
        if (checkValidation()){
            SC.socket.emit("register", [txt_Username.text, txt_Email.text, txt_Password.text]);
            
            SC.socket.on("register") {data, ack in
                switch (data[0] as! String){
                    case "-1":
                        //Username is taken
                        self.serverResponseError(error_number: -1)
                        break;
                    case "-2":
                        //Email is taken
                        self.serverResponseError(error_number: -2)
                        break;
                    case "1":
                        //Success
                        self.btn_Back(sender);
                        return;
                    case "400":
                        //Something went wrong.
                        self.openAlertError(title: "Registration Failed!", message: "Something went wrong, please try again later.")
                        break;
                    default: break;
                }
                
            }
        }
    }
    
    @IBAction func btn_Login(_ sender: Any) {
        btn_Back(sender);
    }
    
    func serverResponseError(error_number: Int){
        var error_message = "";
        
        switch error_number {
            case -1:
                error_message.append("\u{2022} " + ERR_USERNAME_TAKEN);
                break;
            case -2:
                error_message.append("\u{2022} " + ERR_EMAIL_TAKEN);
                break;
            default:
                break;
        }
        
        displayError(error_message: error_message);
    }
    
    func checkValidation() -> Bool{
        var error_message = "";
        var valid = true;
        
        
        if (!isValidUsername(txt_Username.text!)){
            error_message.append("\u{2022} " + ERR_USERNAME_VALID)
            valid = false;
        }
        if (!isValidPassword(txt_Password.text!)){
            if (!valid){
                error_message.append("\n");
            }
            error_message.append("\u{2022} " + ERR_PASSWORD)
            valid = false;
        }
        if (!isValidEmail(txt_Email.text!)){
            if (!valid){
                error_message.append("\n");
            }
            error_message.append("\u{2022} " + ERR_EMAIL_VALID)
            valid = false;
        }
        
        displayError(error_message: error_message);
        
        return valid;
    }
    
    func displayError(error_message: String){
        lbl_Error.isHidden = false;
        lbl_Error.text = error_message;
    }
    
    func isValidUsername(_ username: String) -> Bool {
        if (!username.isAlphanumeric){ return false; }
        if (username.count < 4 || username.count > 12){ return false; }
        
        return true;
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if (password.count < 8){ return false; }
        
        return true;
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
