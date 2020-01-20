//
//  ServerConversation.swift
//  PressIt
//
//  Created by Roe Iton on 13/12/2019.
//  Copyright © 2019 Roe Iton. All rights reserved.
//

import Foundation
import SocketIO

class ServerConversation: NSObject {

    let manager = SocketManager(socketURL: URL(string: "http://10.0.0.57:8080/")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    var viewController: VC_MP_GroupList!
    
    override init() {
        super.init()
        socket = manager.defaultSocket
        addHandlers()
        self.socket.connect()
        
    }
    
    func addViewController(view: VC_MP_GroupList){
        self.viewController = view;
    }
    
    func addHandlers(){
        
        self.socket.on("connect") {data, ack in
             print("\nsocket connected")
        }
        
        self.socket.on("disconnect") {data, ack in
             print("\nsocket disconnected")
        }

        self.socket.on("error") {data, ack in
             print("\nsocket error")
        }
        
        self.socket.on("statusChange") {data, ack in
            print("\nStatus change: \(data)\n")
        }
        
        self.socket.on("allplayers") {data, ack in
            let list = data[0] as? String;
            let players_list = list?.components(separatedBy: "%50");
            
            for p in players_list!{
                let player_details = p.components(separatedBy: "%20");
                
                if (self.viewController != nil && player_details.count >= 3){
                    if (self.viewController.room.getIndexByPlayer(player_ID: player_details[2]) == -1){
                        self.viewController.room.add_Player(nickname: player_details[0], lvl: player_details[1], playerID: player_details[2]);
                    }
                    
                    self.viewController.updatePlayersList();
                }
                
            }
                
            
        }
    }
    
    func getallplayers(gameID: String){
        socket.emit("allplayers", gameID);
    }
    
    func createNewGame(nickname: String, lvl: String){
        socket.emit("newgame", [nickname, lvl]);
    }
    
    func addNewPlayer(nickname: String, lvl: String, gameID: String){
        socket.emit("newplayer", [nickname, lvl, gameID]);
    }
    
    func startGame(gameID: String){
        socket.emit("startgame", gameID);
    }

    func openGame(gameID: String){
        socket.emit("opengame", gameID);
    }
}
