//
//  VC_ClassicGame.swift
//  TapIt
//
//  Created by Roe Iton on 01/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_ClassicGame: UIViewController {
    
    var ui: UI!;
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var img_Circle: UIImageView!
    
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btn_Screen: UIButton!
    @IBOutlet weak var btn_tryAgain: UIButton!
    @IBOutlet weak var btn_leader: UIButton!
    
    @IBOutlet weak var lbl_Taps: UILabel!
    @IBOutlet weak var lbl_timer: UILabel!
    @IBOutlet weak var lbl_record: UILabel!
    
    var game: ClassicGame!
    var gameseconds: Int!
    
    @IBOutlet weak var game_index: UIPageControl!
    
    func adjustUI(){
        btn_Screen.frame.size = self.view.frame.size;
        btn_Screen.frame.origin = CGPoint(x: 0, y: 0);
        
        if (UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            background.image = UIImage(named: "bkg_game_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.height += 8;
            background.frame.origin = CGPoint(x: 0, y: -2);
            
            btn_tryAgain.frame.origin.y += 15;
            game_index.frame.origin.y = self.view.frame.height - 60;
            img_Circle.frame.origin.y = self.view.frame.height / 2 - 140;
            lbl_Taps.frame.origin.y = self.view.frame.height / 2 - 18;
            lbl_timer.frame.origin.y += 18;
            lbl_record.frame.origin.y =  lbl_Taps.frame.origin.y + 40;
            btn_back.frame.origin.y += 18;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro"){
            //Undone yet
            background.image = UIImage(named: "bkg_game_iphone10.png")
            background.frame.size = self.view.frame.size;
            background.frame.size.width += 2;
            background.frame.size.height += 2;
            background.frame.origin = CGPoint(x: -1, y: 0);
            btn_tryAgain.frame.origin.y -= 6;
        }
        else{
            background.frame.origin = CGPoint(x: 0, y: 0);
            background.frame.size.height += 4;
        }
        
        
       // img_Logo.frame.origin = ui.getNewLocation(old_location: img_Logo.frame.origin)
        btn_tryAgain.frame.origin = ui.getNewLocation(old_location: btn_tryAgain.frame.origin)
        //btn_Multiplayer.frame.origin = ui.getNewLocation(old_location: btn_Multiplayer.frame.origin)
        //lbl_Copyright.frame.origin = ui.getNewLocation(old_location: lbl_Copyright.frame.origin)
        
        //img_Logo.frame.size = ui.getNewSize(old_size: img_Logo.frame.size)
        //background.frame.size = ui.getNewSize(old_size: background.frame.size)
        btn_tryAgain.frame.size = ui.getNewSize(old_size: btn_tryAgain.frame.size)
        //btn_Multiplayer.frame.size = ui.getNewSize(old_size: btn_Multiplayer.frame.size)
        //lbl_Copyright.frame.size = ui.getNewSize(old_size: lbl_Copyright.frame.size)
    }
    
    override func viewDidLoad() {
        ui = UI (size: self.view.frame.size);
        adjustUI()
        
        gameseconds = 3;
        //super.viewDidLoad()
        update_gameSeconds_By_Page();
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func updateHiddenButtons(b: Bool!) {
        //btn_Start.isHidden = !b;
        //btn_back.isHidden = !b;
        //btn_leader.isHidden = !b;
        btn_Screen.isHidden = !b;
    }

    @IBAction func btn_Screen(_ sender: Any) {
        if (game.getgameIsOn()){
            game.setTaps();
            img_Circle.wiggle_y();
            lbl_Taps.pulsate();
        }
    }

    @IBAction func btn_tryAgain(_ sender: Any) {
        self.game.startCountToPlay();
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_HSC" {
            if let leaderBoardGame = segue.destination as? VC_LBGame {
                leaderBoardGame.classicgame = gameseconds;
            }
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (game.gameison){ return;}
        
        if (sender.direction == .left && game_index.currentPage != 3) {
            //print("Swipe Left")
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                  self.lbl_timer.center.x -= self.view.bounds.width
                  self.view.layoutIfNeeded()
            }, completion: {finished in
                self.game_index.currentPage += 1;
                self.update_gameSeconds_By_Page()
                
                self.lbl_timer.center.x = self.view.bounds.width;
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                      self.lbl_timer.center.x -= self.view.bounds.width / 2
                      self.view.layoutIfNeeded()
                }, completion: nil)
            }
        )}
            
        if (sender.direction == .right && game_index.currentPage != 0) {
            //print("Swipe Right")
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                  self.lbl_timer.center.x += self.view.bounds.width
                  self.view.layoutIfNeeded()
            }, completion: {finished in
                self.game_index.currentPage -= 1;
                self.update_gameSeconds_By_Page()
                
                self.lbl_timer.center.x = 0;
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                      self.lbl_timer.center.x += self.view.bounds.width / 2
                      self.view.layoutIfNeeded()
                }, completion: nil)
                }
            )}
    }
    
    func update_gameSeconds_By_Page(){
        
        switch game_index.currentPage {
            case 0:
                gameseconds = 3;
                game = ClassicGame(controller: self, seconds: gameseconds);
                break;
            case 1:
                gameseconds = 5;
                game = ClassicGame(controller: self, seconds: gameseconds);
                break;
            case 2:
                gameseconds = 10;
                game = ClassicGame(controller: self, seconds: gameseconds);
                break;
            case 3:
                gameseconds = 15;
                game = ClassicGame(controller: self, seconds: gameseconds);
                break;
        default:
            break;
        }
        
        lbl_record.text = UserDefaults.standard.string(forKey: "HIGH_SCORE_" + String(gameseconds) + "_TAPS")!;
    }
}

