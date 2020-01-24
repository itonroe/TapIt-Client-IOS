//
//  UI_Resize.swift
//  PressIt
//
//  Created by Roe Iton on 16/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//

import Foundation
import UIKit


class UI{
    
    var iphone10 = false;
    var iphone11_pro = false;
    let add_height = 157.0;
    
    var default_height = 738.0;
    var default_width = 414.0;
    
    var height: Double
    var width: Double
    
    init (size:CGSize){
        self.height = Double(size.height);
        self.width = Double(size.width);
        
        if (UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro Max"){
            iphone10 = true;
        }
        else if (UIDevice.modelName == "iPhone 11 Pro"){
            iphone11_pro = true;
        }
    }
    
    func get_Relation_Size(width: Double, height: Double) -> [Double]{
        return [width / self.default_width, height / self.default_height];
    }
    
    func get_Relation_Location(x: Double, y: Double) -> [Double]{
        return [x / self.default_width, y / self.default_height];
    }
    
    func getNewSize(old_size: CGSize) -> CGSize {
        if (iphone10 || iphone11_pro){
            return old_size;
        }
        
        let relation = get_Relation_Size(width: Double(old_size.width), height: Double(old_size.height))
        
        return CGSize (width: width * relation[0], height: height * relation[1]);
    }
    
    func getNewLocation(old_location: CGPoint) -> CGPoint {
        let relation = get_Relation_Location(x: Double(old_location.x), y: Double(old_location.y))
        
        if (iphone11_pro){
            return CGPoint (x: width * relation[0] - 7, y: height * relation[1]);
        }
        
        return CGPoint (x: width * relation[0], y: height * relation[1]);
    }
}
