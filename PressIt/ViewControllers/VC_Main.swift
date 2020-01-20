//
//  VC_Main.swift
//  PressIt
//
//  Created by Roe Iton on 01/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_Main: UIViewController {
    
    var ui: UI!;
    
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var btn_Arcade: UIButton!
    @IBOutlet weak var btn_Classic: UIButton!
    @IBOutlet weak var btn_Multiplayer: UIButton!
    
    @IBOutlet weak var lbl_Copyright: UILabel!
    
    func adjustUI(){
        if (UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            btn_Multiplayer.frame.origin.y -= 12;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro"){
            background.image = UIImage(named: "bkg_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            btn_Multiplayer.frame.origin.y -= 6;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        
        img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        btn_Classic.frame.origin = ui.getNewLocation(old_location: btn_Classic.frame.origin)
        btn_Multiplayer.frame.origin = ui.getNewLocation(old_location: btn_Multiplayer.frame.origin)
        lbl_Copyright.frame.origin = ui.getNewLocation(old_location: lbl_Copyright.frame.origin)
        
        img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        background.frame.size = ui.getNewSize(old_size: background.frame.size)
        btn_Classic.frame.size = ui.getNewSize(old_size: btn_Classic.frame.size)
        btn_Multiplayer.frame.size = ui.getNewSize(old_size: btn_Multiplayer.frame.size)
        lbl_Copyright.frame.size = ui.getNewSize(old_size: lbl_Copyright.frame.size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        overrideUserInterfaceStyle = .light
        
        set_playerData();
        
        reset_Data(classicGame: "0");
        reset_Data(classicGame: "3");
        reset_Data(classicGame: "5");
        reset_Data(classicGame: "10");
        reset_Data(classicGame: "15");
    }
    
    func set_playerData(){
        if (UserDefaults.standard.value(forKey: "PLAYER_NICKNAME") == nil){
            UserDefaults.standard.set("Itonroe", forKey: "PLAYER_NICKNAME")
            UserDefaults.standard.set("1", forKey: "PLAYER_LEVEL")
            UserDefaults.standard.set("0", forKey: "PLAYER_LEVEL_STATUS")
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
    
    @IBAction func btn_arcade(_ sender: Any) {
        performSegue(withIdentifier: "segue_arcade", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_arcade" {
            if let arcade = segue.destination as? VC_ArcadeGame {
                arcade.gameseconds = 5;
            }
        }
    }
}

