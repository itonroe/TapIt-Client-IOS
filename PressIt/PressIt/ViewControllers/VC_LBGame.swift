//
//  VC_LBGame.swift
//  PressIt
//
//  Created by Roe Iton on 03/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_LBGame: UIViewController {
    
    var classicgame: Int!;
    
    @IBOutlet weak var img_Title: UIImageView!
    
    @IBOutlet weak var lbl_HS_Fname: UILabel!
    @IBOutlet weak var lbl_HS_Taps: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //img_Title.image = UIImage(named: "expand_title_" + String(classicgame) + ".png");
        
        
        lbl_HS_Taps.text = UserDefaults.standard.string(forKey: "HIGH_SCORE_" + String(classicgame) + "_TAPS")!;
        lbl_HS_Fname.text = UserDefaults.standard.string(forKey: "HIGH_SCORE_" + String(classicgame) + "_LEADER")!;
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
