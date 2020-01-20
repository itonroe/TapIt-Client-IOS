//
//  ArcadeGame.swift
//  TapIt
//
//  Created by Roe Iton on 02/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

class ArcadeGame {
    
    
    /*==================
         Variables
    ===================*/
    
    //-----GENERAL VARIABLES-----
    var controller: VC_ArcadeGame!
    var gameseconds: Int!
    var countdown: Int!
    var taps: Int!
    var coins: Int!
    var timer_mil: Timer!
    var timer_sec: Timer!
    var gameison: Bool!
    var gamepaused: Bool!
    
    //-----ARCADE VARIABLES-----
    let epsylon_taps = 8;
    let epsylon_time = 5;
    var delta_coins: Int!
    var step: Int!
    var seconds_per_step: Int!
    var taps_per_step: Int!
    
    
    let screen_right_border = 353
    let screen_left_border = 11
    let screen_top_border = 11
    let screen_bottom_border = 597
    
//    var taps_per_ster_array = [40, 80, 105, 150, , ]
    
    
    /*==================
         Constructor
    ===================*/
    
    //Build a new Classic Game
    init (controller: VC_ArcadeGame, seconds: Int){
        self.controller = controller;
        self.gameseconds = seconds;
        self.countdown = seconds * 100;
        self.controller.lbl_Taps.text = "Tap & Start";
        self.controller.lbl_timer.text = getTimeInFourDigits();
        self.controller.btn_tryAgain.isHidden = true;
        self.controller.btn_Screen.isHidden = false;
        self.controller.btn_Pause.isHidden = true;
        self.controller.lbl_tapstobeat.isHidden = true;
        self.taps = 0;
        self.gameison = false;
        self.gamepaused = false;
        self.step = 1;
        self.taps_per_step = step_toTaps(s: 1);
        self.seconds_per_step = step_toSeconds(s: 1);
        self.coins = 0;
        self.delta_coins = 50;
        self.controller.lbl_coins.text = "00";
        self.controller.lbl_tapstobeat.text = String(taps_per_step);
    }
    
    
    /*==================
     General   Functions
     ===================*/
    
    //Start 3..2..1 Go
    public func startCountToPlay(){
        if (controller.lbl_timer.text != "3" && controller.lbl_timer.text != "2" && controller.lbl_timer.text != "1"){
        controller.lbl_timer.text = "3";
        self.controller.btn_leader.isHidden = true;
        self.controller.btn_back.isHidden = true;
        self.timer_sec = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true);
        }
    }
    
    //Start the Game
    public func startGame(){
        if (gamepaused && gameison){
            self.timer_sec.invalidate();
            self.timer_sec = nil;
            self.gamepaused = false;
            self.controller.gamepaused = false;
            self.controller.btn_Screen.isHidden = false;
        }
        //if (!gameison ) {
            //self.controller.lbl_Taps.text = "0";}
        gameison = true;
        self.controller.btn_Pause.isHidden = false;
        self.controller.btn_leader.isHidden = true;
        self.controller.btn_back.isHidden = true;
        self.controller.lbl_tapstobeat.isHidden = false;
        self.timer_mil = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true);
    }

    //Stop the Game
    public func stopGame(){
        self.gameison = false;
        self.timer_mil.invalidate();
        self.timer_mil = nil;
        self.checkAndSetHighScore();
        self.controller.btn_leader.isHidden = false;
        self.controller.btn_back.isHidden = false;
        self.controller.btn_tryAgain.isHidden = false;
        self.controller.btn_Screen.isHidden = true;
        self.controller.btn_Pause.isHidden = true;
    }
    
    //Pause Game
    public func pauseGame(){
        if (!gamepaused){
            self.gamepaused = true;
            self.controller.gamepaused = true;
            self.timer_mil.invalidate()
            self.timer_mil = nil;
            self.controller.btn_leader.isHidden = false;
            self.controller.btn_back.isHidden = false;
            self.controller.btn_Screen.isHidden = true;
            self.controller.btn_Pause.setImage(UIImage(named: "btn_resume_green.png"), for: .normal)
        }
    }
    
    //Resume Game
    public func resumeGame(){
        if(gameison){
            startCountToPlay()
            self.controller.btn_Pause.setImage(UIImage(named: "btn_pause_green.png"), for: .normal)}
        
        //self.controller.btn_leader.isHidden = true;
        //self.controller.btn_back.isHidden = true;
        //self.controller.btn_Screen.isHidden = false;
        //self.controller.btn_Pause.isHidden = false;
        //self.timer_mil = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true);
    }
    
    //Reset the Game
    public func resetGame(){
        self.countdown = self.gameseconds * 100;
        self.controller.lbl_Taps.text = "Tap & Start";
        self.controller.lbl_timer.text = getTimeInFourDigits();
        self.controller.btn_tryAgain.isHidden = true;
        self.controller.btn_Screen.isHidden = false;
        self.controller.lbl_tapstobeat.isHidden = true;
        self.taps = 0;
        self.coins = 0;
        self.delta_coins = 50;
        self.controller.lbl_coins.text = "00";
        self.gameison = false;
    }
    
    //Random select coin
    public func randomCoin(){
        
        if (Int.random(in: 1 ... self.delta_coins!) == 1){
            createCoin();
        }
    }
    
    //Create coin
    public func createCoin(){
        if (self.controller.btn_coin.isHidden == true){
            let x = Int.random(in: self.screen_left_border ... self.screen_right_border)
            let y = Int.random(in: self.screen_top_border ... self.screen_bottom_border)
            
            self.controller.btn_coin.frame.origin = CGPoint(x: x, y: y);
            self.controller.btn_coin.isHidden = false;
        }
    }
    
    //Collected coin
    public func collectCoin(){
        self.controller.btn_coin.isHidden = true;
        self.coins += 1;
        if (coins < 10){
            self.controller.lbl_coins.text = "0" + String(self.coins);}
        else { self.controller.lbl_coins.text = String(self.coins);}
        self.delta_coins -= 1;
    }
    
    //Updating the countdown
    @objc func updateCountdown(){
        if (self.gameison && !self.gamepaused){
            self.controller.lbl_timer.text = getTimeInFourDigits();
            self.countdown -= 1;
            if (countdown % 10 == 0)
            {self.randomCoin()}

            if (self.countdown == 0){
                self.controller.lbl_timer.text = "00:00";
                self.controller.btn_Screen.isHidden = true;
                stopGame();
            }
        } else {
            var temp = self.controller.lbl_timer.text;
            
            switch (controller.lbl_timer.text) {
                case "3": temp = "2"; break;
                case "2": temp = "1"; break;
                case "1":
                        startGame();
                    
                    break;
                default: break;
            }
            
            controller.lbl_timer.text = temp;
    
        }
    }
    
    //Returning the countdown in XX:YY Format
    public func getTimeInFourDigits() -> String {
        if (countdown <= 0) {return "00:00"}
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
        let high_score = UserDefaults.standard.value(forKey: "HIGH_SCORE_0_TAPS") as! Int;
        
        if (taps > high_score){
            openAlertToGetInfo();
            UserDefaults.standard.set(taps, forKey: "HIGH_SCORE_0_TAPS");
        }
    }
    
    //Open an alert with a fullname field to update the name of the leader
    func openAlertToGetInfo() {
        let alert = UIAlertController(title: "Congratulations!", message: "New highscore achived", preferredStyle: UIAlertController.Style.alert )
        
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                UserDefaults.standard.set(textField.text, forKey: "HIGH_SCORE_0_LEADER");
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
        
        //Specific to ARCADE MODE
        if (self.taps  >= taps_per_step){
            step += 1;
            set_per_Step()
        }
            
        self.controller.lbl_Taps.text = getTaps();
    }
    
    public func getRecordTaps() -> String {
        return UserDefaults.standard.string(forKey: "HIGH_SCORE_" + String(self.gameseconds) + "_TAPS")!;
    }
    
    //-----ARCADE FUNCTIONS-----
    func step_toSeconds(s: Int!) -> Int{
        if (s == 0){ return 0; }
        if (s == 1){ return 5; }
        
        return seconds_per_step + get_step_progress(s: s - 1)
    }
    
    func step_toTaps(s: Int!) -> Int{
        
        if (s == 1){ return 40; }
        
        return taps_per_step + (epsylon_taps * get_step_progress(s: s));
        
    }
    
    func get_step_progress(s: Int!) -> Int {
        
        var t = (Double(s)/2) - 0.5;
        
        if (s % 2 == 0){
            t.round(.down)
        }
        else{
            t.round(.up)
        }
        
        if ( Int(t) >= epsylon_time) { return 1;}
        
        return (epsylon_time - Int(t))
    }
    
    func set_per_Step(){
        //self.seconds_per_step = step_toSeconds(s: self.step);
        self.taps_per_step = step_toTaps(s: self.step);
        self.controller.lbl_tapstobeat.text = String(taps_per_step);
        
        
        self.countdown += (100 * get_step_progress(s: self.step));
        self.controller.lbl_timer.text = getTimeInFourDigits();
    }
}
