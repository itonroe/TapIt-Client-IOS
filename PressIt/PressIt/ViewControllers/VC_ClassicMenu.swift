//
//  VC_ClassicMenu.swift
//  PressIt
//
//  Created by Roe Iton on 01/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_ClassicMenu: UIViewController {
    
    var chosenGame: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    @IBAction func btn_classic3(_ sender: Any) {
        chosenGame = 3;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    
    @IBAction func btn_classic5(_ sender: Any) {
        chosenGame = 5;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    
    @IBAction func btn_classic10(_ sender: Any) {
        chosenGame = 10;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
    }
    
    @IBAction func btn_classic15(_ sender: Any) {
        chosenGame = 15;
        performSegue(withIdentifier: "segue_NewClassicGame", sender: self);
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
        if segue.identifier == "segue_NewClassicGame" {
            if let newClassicGame = segue.destination as? VC_ClassicGame {
                newClassicGame.gameseconds = chosenGame;
            }
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
                print("Swipe Left")
            //let labelPosition = CGPoint(x: swipeLabel.frame.origin.x - 50.0, y: swipeLabel.frame.origin.y)
            //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: swipeLabel.frame.size.width, height: swipeLabel.frame.size.height)
        }
            
        if (sender.direction == .right) {
            print("Swipe Right")
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromLeft
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
            //let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
            //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
        }
    }
}

