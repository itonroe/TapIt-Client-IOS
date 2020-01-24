//
//  VC_Login.swift
//  PressIt
//
//  Created by Roe Iton on 24/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit

class VC_Login: UIViewController {
    
    @IBOutlet weak var txt_Username: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        txt_Username.setLeftPaddingPoints(20);
        txt_Password.setLeftPaddingPoints(20);
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
    
}
