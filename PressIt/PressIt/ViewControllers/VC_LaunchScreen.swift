//
//  VC_LaunchScreen.swift
//  PressIt
//
//  Created by Roe Iton on 26/02/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_LaunchScreen: UIViewController {
    @IBOutlet weak var img_Game: UIImageView!
    
    override func viewDidLoad() {
        img_Game.frame.origin.x = self.view.frame.width / 2;
        img_Game.frame.origin.y = self.view.frame.height / 2;
    }
    
}
