//
//  VC_MP_Score.swift
//  PressIt
//
//  Created by Roe Iton on 18/02/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_MP_Score: UIViewController {
    
    var ui: UI!
    @IBOutlet weak var lbl_player1: UILabel!
    @IBOutlet weak var lbl_player_taps_1: UILabel!
    @IBOutlet weak var lbl_player_lvl_1: UILabel!
    @IBOutlet weak var bar_player1: UIImageView!
    
    @IBOutlet weak var lbl_player2: UILabel!
    @IBOutlet weak var lbl_player_taps_2: UILabel!
    @IBOutlet weak var lbl_player_lvl_2: UILabel!
    @IBOutlet weak var bar_player2: UIImageView!
    
    @IBOutlet weak var lbl_player3: UILabel!
    @IBOutlet weak var lbl_player_taps_3: UILabel!
    @IBOutlet weak var lbl_player_lvl_3: UILabel!
    @IBOutlet weak var bar_player3: UIImageView!
    
    @IBOutlet weak var lbl_player4: UILabel!
    @IBOutlet weak var lbl_player_taps_4: UILabel!
    @IBOutlet weak var lbl_player_lvl_4: UILabel!
    @IBOutlet weak var bar_player4: UIImageView!
    
    @IBOutlet weak var lbl_player5: UILabel!
    @IBOutlet weak var lbl_player_taps_5: UILabel!
    @IBOutlet weak var lbl_player_lvl_5: UILabel!
    @IBOutlet weak var bar_player5: UIImageView!
    
    @IBOutlet weak var lbl_lvl: UILabel!
    @IBOutlet weak var lbl_taps: UILabel!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btn_sharescoreboard: UIButton!
    
    func adjustUI(){
           if (UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            
               btn_sharescoreboard.frame.origin.y += 15;
               lbl_player1.frame.origin.y += 100;
               lbl_player_taps_1.frame.origin.y += 100;
               lbl_player_lvl_1.frame.origin.y += 100;
               bar_player1.frame.origin.y += 100;
               lbl_player2.frame.origin.y += 100;
               lbl_player_taps_2.frame.origin.y += 100;
               lbl_player_lvl_2.frame.origin.y += 100;
               bar_player2.frame.origin.y += 100;
               lbl_player3.frame.origin.y += 100;
               lbl_player_taps_3.frame.origin.y += 100;
               lbl_player_lvl_3.frame.origin.y += 100;
               bar_player3.frame.origin.y += 100;
               lbl_player4.frame.origin.y += 100;
               lbl_player_taps_4.frame.origin.y += 100;
               lbl_player_lvl_4.frame.origin.y += 100;
               bar_player4.frame.origin.y += 100;
               lbl_player5.frame.origin.y += 100;
               lbl_player_taps_5.frame.origin.y += 100;
               lbl_player_lvl_5.frame.origin.y += 100;
               bar_player5.frame.origin.y += 100;
            
            
               lbl_lvl.frame.origin.y += 100;
               lbl_taps.frame.origin.y += 100;
               btn_back.frame.origin.y += 18;
            
            
               btn_sharescoreboard.frame.origin = ui.getNewLocation(old_location: btn_sharescoreboard.frame.origin)
           }
           else if (UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS"  ){
            
                  btn_sharescoreboard.frame.origin.y += 100;
                  btn_sharescoreboard.frame.origin.x -= 20;
            
                  lbl_player1.frame.origin.y += 40;
                  lbl_player_taps_1.frame.origin.y += 40;
                  lbl_player_lvl_1.frame.origin.y += 40;
                  bar_player1.frame.origin.y += 40;
                  lbl_player2.frame.origin.y += 40;
                  lbl_player_taps_2.frame.origin.y += 40;
                  lbl_player_lvl_2.frame.origin.y += 40;
                  bar_player2.frame.origin.y += 40;
                  lbl_player3.frame.origin.y += 40;
                  lbl_player_taps_3.frame.origin.y += 40;
                  lbl_player_lvl_3.frame.origin.y += 40;
                  bar_player3.frame.origin.y += 40;
                  lbl_player4.frame.origin.y += 40;
                  lbl_player_taps_4.frame.origin.y += 40;
                  lbl_player_lvl_4.frame.origin.y += 40;
                  bar_player4.frame.origin.y += 40;
                  lbl_player5.frame.origin.y += 40;
                  lbl_player_taps_5.frame.origin.y += 40;
                  lbl_player_lvl_5.frame.origin.y += 40;
                  bar_player5.frame.origin.y += 40;
               
               
                  lbl_lvl.frame.origin.y += 40;
                  lbl_taps.frame.origin.y += 40;
            
            

                   lbl_player1.frame.origin.x -= 20;
                   lbl_player_taps_1.frame.origin.x -= 20;
                   lbl_player_lvl_1.frame.origin.x -= 20;
                   bar_player1.frame.origin.x -= 20;
                   lbl_player2.frame.origin.x -= 20;
                   lbl_player_taps_2.frame.origin.x -= 20;
                   lbl_player_lvl_2.frame.origin.x -= 20;
                   bar_player2.frame.origin.x -= 20;
                   lbl_player3.frame.origin.x -= 20;
                   lbl_player_taps_3.frame.origin.x -= 20;
                   lbl_player_lvl_3.frame.origin.x -= 20;
                   bar_player3.frame.origin.x -= 20;
                   lbl_player4.frame.origin.x -= 20;
                   lbl_player_taps_4.frame.origin.x -= 20;
                   lbl_player_lvl_4.frame.origin.x -= 20;
                   bar_player4.frame.origin.x -= 20;
                   lbl_player5.frame.origin.x -= 20;
                   lbl_player_taps_5.frame.origin.x -= 20;
                   lbl_player_lvl_5.frame.origin.x -= 20;
                   bar_player5.frame.origin.x -= 20;
                
                
                   lbl_lvl.frame.origin.x -= 20;
                   lbl_taps.frame.origin.x -= 20;
                  btn_back.frame.origin.y += 18;
           }
             else if (UIDevice.modelName == "iPhone 8" || UIDevice.modelName == "iPhone 7" || UIDevice.modelName == "iPhone 6" || UIDevice.modelName == "iPhone 6s"){
            
                  btn_sharescoreboard.frame.origin.y -= 40;
                  btn_sharescoreboard.frame.origin.x -= 20;
            
                  lbl_player1.frame.origin.y -= 40;
                  lbl_player_taps_1.frame.origin.y -= 40;
                  lbl_player_lvl_1.frame.origin.y -= 40;
                  bar_player1.frame.origin.y -= 40;
                  lbl_player2.frame.origin.y -= 40;
                  lbl_player_taps_2.frame.origin.y -= 40;
                  lbl_player_lvl_2.frame.origin.y -= 40;
                  bar_player2.frame.origin.y -= 40;
                  lbl_player3.frame.origin.y -= 40;
                  lbl_player_taps_3.frame.origin.y -= 40;
                  lbl_player_lvl_3.frame.origin.y -= 40;
                  bar_player3.frame.origin.y -= 40;
                  lbl_player4.frame.origin.y -= 40;
                  lbl_player_taps_4.frame.origin.y -= 40;
                  lbl_player_lvl_4.frame.origin.y -= 40;
                  bar_player4.frame.origin.y -= 40;
                  lbl_player5.frame.origin.y -= 40;
                  lbl_player_taps_5.frame.origin.y -= 40;
                  lbl_player_lvl_5.frame.origin.y -= 40;
                  bar_player5.frame.origin.y -= 40;
               
               
                  lbl_lvl.frame.origin.y -= 40;
                  lbl_taps.frame.origin.y -= 40;
            
            

                   lbl_player1.frame.origin.x -= 20;
                   lbl_player_taps_1.frame.origin.x -= 20;
                   lbl_player_lvl_1.frame.origin.x -= 20;
                   bar_player1.frame.origin.x -= 20;
                   lbl_player2.frame.origin.x -= 20;
                   lbl_player_taps_2.frame.origin.x -= 20;
                   lbl_player_lvl_2.frame.origin.x -= 20;
                   bar_player2.frame.origin.x -= 20;
                   lbl_player3.frame.origin.x -= 20;
                   lbl_player_taps_3.frame.origin.x -= 20;
                   lbl_player_lvl_3.frame.origin.x -= 20;
                   bar_player3.frame.origin.x -= 20;
                   lbl_player4.frame.origin.x -= 20;
                   lbl_player_taps_4.frame.origin.x -= 20;
                   lbl_player_lvl_4.frame.origin.x -= 20;
                   bar_player4.frame.origin.x -= 20;
                   lbl_player5.frame.origin.x -= 20;
                   lbl_player_taps_5.frame.origin.x -= 20;
                   lbl_player_lvl_5.frame.origin.x -= 20;
                   bar_player5.frame.origin.x -= 20;
                
                
                   lbl_lvl.frame.origin.x -= 20;
                   lbl_taps.frame.origin.x -= 20;
           }
           else{
           }
       }
    
    override func viewDidLoad() {
        ui = UI (size: self.view.frame.size);

        adjustUI()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        updatePlayersList()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func updatePlayersList(){
        hidePlayerList();
        var i = 0;
        for player in room.sortByTaps(){
            setPlayer_Fields(index: room.get_NumberOfPlayers() - i - 1, nickname: player.get_Nickname(), lvl: player.get_Level(), taps: player.get_Taps())
            
            i += 1;
        }
    }
    
    func hidePlayerList(){
        lbl_player2.isHidden = true;
        lbl_player_lvl_2.isHidden = true;
        lbl_player_taps_2.isHidden = true;
        bar_player2.isHidden = true;
        
        lbl_player3.isHidden = true;
        lbl_player_lvl_3.isHidden = true;
        lbl_player_taps_3.isHidden = true;
        bar_player3.isHidden = true;
        
        lbl_player4.isHidden = true;
        lbl_player_lvl_4.isHidden = true;
        lbl_player_taps_4.isHidden = true;
        bar_player4.isHidden = true;
        
        lbl_player5.isHidden = true;
        lbl_player_lvl_5.isHidden = true;
        lbl_player_taps_5.isHidden = true;
        bar_player5.isHidden = true;
    }
    
    func setPlayer_Fields(index: Int, nickname: String, lvl: String, taps: String){
        switch (index + 1) {
        case 1:
            lbl_player1.text = nickname;
            lbl_player_lvl_1.text = lvl;
            lbl_player_taps_1.text = taps;
            break;
        case 2:
            lbl_player2.text = nickname;
            lbl_player_lvl_2.text = lvl;
            lbl_player_taps_2.text = taps;
            lbl_player2.isHidden = false;
            lbl_player_lvl_2.isHidden = false;
            lbl_player_taps_2.isHidden = false;
            bar_player2.isHidden = false;
            break;
        case 3:
            lbl_player3.text = nickname;
            lbl_player_lvl_3.text = lvl;
            lbl_player_taps_3.text = taps;
            lbl_player3.isHidden = false;
            lbl_player_lvl_3.isHidden = false;
            lbl_player_taps_3.isHidden = false;
            bar_player3.isHidden = false;
            break;
        case 4:
            lbl_player4.text = nickname;
            lbl_player_lvl_4.text = lvl;
            lbl_player_taps_4.text = taps;
            lbl_player4.isHidden = false;
            lbl_player_lvl_4.isHidden = false;
            lbl_player_taps_4.isHidden = false;
            bar_player4.isHidden = false;
            break;
        case 5:
            lbl_player5.text = nickname;
            lbl_player_lvl_5.text = lvl;
            lbl_player_taps_5.text = taps;
            lbl_player5.isHidden = false;
            lbl_player_lvl_5.isHidden = false;
            lbl_player_taps_5.isHidden = false;
            bar_player5.isHidden = false;
            break;
        default:
            break;
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_ShareScore(_ sender: UIButton) {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)

         // Draw view in that context
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

         // And finally, get image
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
        
        let activityVC = UIActivityViewController(activityItems: ["Hey! look at this scoreboard on Tap It - Multiplayer", image], applicationActivities: nil)
        activityVC.title = "Tap It - Multiplayer";
        
        activityVC.popoverPresentationController?.sourceView = sender
        self.present(activityVC, animated: true, completion: nil)
    }
}
