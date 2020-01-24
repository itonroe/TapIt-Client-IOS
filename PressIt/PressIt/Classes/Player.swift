//
//  Player.swift
//  PressIt
//
//  Created by Roe Iton on 14/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//


class Player {

    /*==================
         Variables
    ===================*/

    var nickname: String!
    var lvl: String!
    var playerID: String!
    
    
    init (nickname:String!, lvl: String!, playerID: String){
        self.nickname = nickname;
        self.lvl = lvl;
        self.playerID = playerID;
    }
    
    func get_Nickname() -> String{
        return nickname;
    }
    
    func get_Level() -> String{
        return lvl;
    }
    
    func get_playerID() -> String{
        return playerID;
    }
}
