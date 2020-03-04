//
//  VC_Main.swift
//  PressIt
//
//  Created by Roe Iton on 01/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit
import SAConfettiView
import AVFoundation


var backgroundMusicPlayer: AVAudioPlayer = AVAudioPlayer()

var SIGNEDIN = UserDefaults.standard.bool(forKey: "SIGN_IN");
var MP_PLAYER_NICKNAME = UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") as! String;
var MP_PLAYER_LEVEL = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as! String;
var MP_PLAYER_LEVEL_STATUS = UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as! String;


class VC_Main: UIViewController {
    
    var ui: UI!;
    
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var btn_Sound: UIButton!
    @IBOutlet weak var btn_Arcade: UIButton!
    @IBOutlet weak var btn_Classic: UIButton!
    @IBOutlet weak var btn_Multiplayer: UIButton!
    
    @IBOutlet weak var lbl_Copyright: UILabel!
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            btn_Multiplayer.frame.origin.y -= 12;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            btn_Multiplayer.frame.origin.y -= 6;
            btn_Multiplayer.frame.origin.x -= 4;
            btn_Classic.frame.origin.x -= 4;
        }else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s"){
           background.frame.size = self.view.frame.size;
            
            btn_Multiplayer.frame.origin.y += 4;
            btn_Multiplayer.frame.origin.x -= 12;
            btn_Classic.frame.origin.x -= 12;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
            
        }
        
        
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        btn_Classic.frame.origin = ui.getNewLocation(old_location: btn_Classic.frame.origin)
        btn_Multiplayer.frame.origin = ui.getNewLocation(old_location: btn_Multiplayer.frame.origin)
        btn_Sound.frame.origin = ui.getNewLocation(old_location: btn_Sound.frame.origin)
        lbl_Copyright.frame.origin = ui.getNewLocation(old_location: lbl_Copyright.frame.origin)
        
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        //background.frame.size = ui.getNewSize(old_size: background.frame.size)
        //btn_Classic.frame.size = ui.getNewSize(old_size: btn_Classic.frame.size)
        //btn_Multiplayer.frame.size = ui.getNewSize(old_size: btn_Multiplayer.frame.size)
        btn_Sound.frame.size = ui.getNewSize(old_size: btn_Sound.frame.size)
        lbl_Copyright.frame.size = ui.getNewSize(old_size: lbl_Copyright.frame.size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initMusicBackground();
        
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        //UserDefaults.standard.removeObject(forKey: "SIGN_IN")
        
        if (UserDefaults.standard.value(forKey: "SIGN_IN") == nil){
            initUserDefaultData()
        }
        
        SIGNEDIN = UserDefaults.standard.bool(forKey: "SIGN_IN");
        MP_PLAYER_NICKNAME = UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") as! String;
        MP_PLAYER_LEVEL = UserDefaults.standard.value(forKey: "PLAYER_LEVEL") as! String;
        print(UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as! String);
        MP_PLAYER_LEVEL_STATUS = UserDefaults.standard.value(forKey: "PLAYER_LEVEL_STATUS") as! String;
        
        
        setBackgroundSound();
        
        
        if (UserDefaults.standard.value(forKey: "MP_GAME_ID") != nil){
            performSegue(withIdentifier: "segue_multiplayer", sender: self)
        }
        
        reset_Data(classicGame: "0");
        reset_Data(classicGame: "3");
        reset_Data(classicGame: "5");
        reset_Data(classicGame: "10");
        reset_Data(classicGame: "15");
    }
    
    func initUserDefaultData(){
        
        UserDefaults.standard.set("On", forKey: "Sound")
        UserDefaults.standard.set(false, forKey: "SIGN_IN")
        UserDefaults.standard.set("Guest", forKey: "PLAYER_NICKNAME")
        UserDefaults.standard.set("1", forKey: "PLAYER_LEVEL")
        UserDefaults.standard.set("0.0", forKey: "PLAYER_LEVEL_STATUS")
        UserDefaults.standard.set("On", forKey: "Sound")
        
    }
    
    func setBackgroundSound(){
        if (UserDefaults.standard.value(forKey: "Sound") as! String == "On"){
            backgroundMusicPlayer.play();
            btn_Sound.setImage(UIImage(systemName: "speaker.3"), for: .normal);
        }
    }
    
    func reset_Data(classicGame: String){
        if (UserDefaults.standard.value(forKey: "HIGH_SCORE_" + classicGame + "_TAPS") == nil){
            UserDefaults.standard.set(0, forKey: "HIGH_SCORE_" + classicGame + "_TAPS");
        }
        
        if (UserDefaults.standard.value(forKey: "HIGH_SCORE_" + classicGame + "_LEADER") == nil){
            UserDefaults.standard.set("There isn't a leader yet", forKey: "HIGH_SCORE_" + classicGame + "_LEADER");
        }
    }
    
    @IBAction func btn_Classic(_ sender: Any) {
        performSegue(withIdentifier: "segue_classic", sender: self)
    }
    
    @IBAction func btn_MultiPlayer(_ sender: Any) {
        if (!SIGNEDIN){
            performSegue(withIdentifier: "segue_login", sender: self)
        }
        else{
            performSegue(withIdentifier: "segue_multiplayer", sender: self)
        }
    }
    
    @IBAction func btn_arcade(_ sender: Any) {
        performSegue(withIdentifier: "segue_arcade", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_arcade" {
            if let arcade = segue.destination as? VC_ArcadeGame {
                arcade.gameseconds = 5;
            }
        }
        
        //if segue.identifier == "segue_classic" {
        //    if let classic = segue.destination as? VC_ClassicGame {
        //    }
        //}
        
        //if segue.identifier == "segue_classic" {
          //  if let classic = segue.destination as? VC_ClassicMenu {
                
            //}
        //}
    }
    @IBAction func btn_Sound(_ sender: Any) {
        if (backgroundMusicPlayer.isPlaying){
            btn_Sound.setImage(UIImage(systemName: "speaker.slash"), for: .normal);
            backgroundMusicPlayer.stop();
            UserDefaults.standard.set("Off", forKey: "Sound")
        }
        else {
            btn_Sound.setImage(UIImage(systemName: "speaker.3"), for: .normal);
            backgroundMusicPlayer.play();
            UserDefaults.standard.set("On", forKey: "Sound")
        }
    }
    
    func initMusicBackground(){
        if let musicURL = Bundle.main.url(forResource: "bkg_music", withExtension: "mp3") {
        
            do {
                try backgroundMusicPlayer = AVAudioPlayer(contentsOf: musicURL)
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
            } catch {
                print(error);
            }
        }
    }
}

