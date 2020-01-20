//
//  ClassicGame.swift
//  TapIt
//
//  Created by Roe Iton on 02/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

class ClassicGame {

    /*==================
         Variables
    ===================*/

    var controller: VC_ClassicGame!
    var gameseconds: Int!
    var countdown: Int!
    var taps: Int!
    var timer: Timer!
    var gameison: Bool!
    
    
    /*==================
         Constructor
    ===================*/
    
    //Build a new Classic Game
    init (controller: VC_ClassicGame, seconds: Int){
        self.controller = controller;
        self.gameseconds = seconds;
        self.countdown = seconds * 100;
        self.controller.lbl_Taps.text = "Tap & Start";
        self.controller.lbl_timer.text = getTimeInFourDigits();
        self.controller.updateHiddenButtons(b: true);
        self.taps = 0;
        self.gameison = false;
    }
    
    
    /*==================
     General   Functions
     ===================*/
    
    //Start the Game
    public func startGame(){
        gameison = true;
        self.controller.lbl_Taps.text = "0";
        self.controller.btn_leader.isHidden = true;
        self.controller.btn_back.isHidden = true;
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true);
    }

    //Stop the Game
    public func stopGame(){
        self.gameison = false;
        self.timer.invalidate();
        self.timer = nil;
        self.checkAndSetHighScore();
        self.controller.updateHiddenButtons(b: false);
        self.controller.btn_leader.isHidden = false;
        self.controller.btn_back.isHidden = false;
    }
    
    //Reset the Game
    public func resetGame(){
        self.countdown = self.gameseconds * 100;
        self.controller.lbl_Taps.text = "Tap & Start";
        self.controller.lbl_timer.text = getTimeInFourDigits();
        self.controller.updateHiddenButtons(b: true);
        self.taps = 0;
        self.gameison = false;
    }
    
    //Updating the countdown
    @objc func updateCountdown(){
        if (self.gameison){
            self.controller.lbl_timer.text = getTimeInFourDigits();
            self.countdown -= 1;

            if (self.countdown == 0){
                self.controller.lbl_timer.text = "00:00";
                stopGame();
            }
        }
    }
    
    //Returning the countdown in XX:YY Format
    public func getTimeInFourDigits() -> String {
        let seconds = countdown / 100;
        let milliseconds = countdown % 100;
        
        var time: String!
        
        if (seconds > 9){
            time = String(seconds) + ":";
        } else {
            time = "0" + String(seconds) + ":";
        }
        
        if (milliseconds > 9) {
            return time + String(milliseconds);
        }
        else {
            return time + "0" + String(milliseconds);
        }
    }
    
    //Check if there is a new high score, if it is Update
    public func checkAndSetHighScore() {
        let high_score = UserDefaults.standard.value(forKey: "HIGH_SCORE_" + String(self.gameseconds) + "_TAPS") as! Int;
        
        if (taps > high_score){
            openAlertToGetInfo();
            UserDefaults.standard.set(taps, forKey: "HIGH_SCORE_" + String(self.gameseconds) + "_TAPS");
        }
    }
    
    //Open an alert with a fullname field to update the name of the leader
    func openAlertToGetInfo() {
        let alert = UIAlertController(title: "Congratulations!", message: "New highscore achived", preferredStyle: UIAlertController.Style.alert )
        
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                UserDefaults.standard.set(textField.text, forKey: "HIGH_SCORE_" + String(self.gameseconds) + "_LEADER");
                print("LEADER : \(textField.text!)")
            } else {
                print("LEADER is Empty...")
            }
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Enter your name"
            textField.textColor = .black
        }
        
        alert.addAction(save)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)

        self.controller.present(alert, animated:true, completion: nil)
    }
    
    
    /*==================
     Get & Set Functions
    ===================*/
    
    public func getTaps() -> String!{
        return String(self.taps);
    }
    
    public func getgameIsOn() -> Bool!{
        return self.gameison;
    }
    
    public func setTaps() {
        self.taps += 1;
        self.controller.lbl_Taps.text = getTaps();
    }
    
    public func getRecordTaps() -> String {
        return UserDefaults.standard.string(forKey: "HIGH_SCORE_" + String(self.gameseconds) + "_TAPS")!;
    }
}
