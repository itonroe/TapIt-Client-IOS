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

    let manager = SocketManager(socketURL: URL(string: "ws://press-it.herokuapp.com/")!, config: [.log(true), .compress])
    //let manager = SocketManager(socketURL: URL(string: "http://10.0.0.57:8080/")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    var viewController: VC_MP_GroupList!
    var game: VC_MP_Game!
    
    override init() {
        super.init()
        socket = manager.defaultSocket
        addHandlers()
        self.socket.connect()
        
    }
    
    func addViewController(view: VC_MP_GroupList){
        self.viewController = view;
    }
    
    func addViewGame(view: VC_MP_Game){
        self.game = view;
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
                    if (room.getIndexByPlayer(player_ID: player_details[2]) == -1){
                        room.add_Player(nickname: player_details[0], lvl: player_details[1], playerID: player_details[2]);
                    }
                    
                    self.viewController.updatePlayersList();
                }
                
            }
        }
        
        self.socket.on("get_score") {data, ack in
                   let list = data[0] as? String;
                   let players_list = list?.components(separatedBy: "%50");
                   
                   for p in players_list!{
                       let player_details = p.components(separatedBy: "%20");
                       
                       if (self.viewController != nil && player_details.count >= 2){
                           let player_Index = room.getIndexByPlayer(player_ID: player_details[0])
                        
                           if (player_Index != -1){
                            room.players[player_Index].set_Taps(taps: player_details[1]);
                           }
                       }
                       
                   }
            
                   self.game.performSegue(withIdentifier: "segue_score", sender: self.game)
               }
        
        self.socket.on("playerexit") {data, ack in
            if (self.viewController != nil){
                let playerID = data[0] as! String;
                if (playerID != ""){
                    room.remove_Player(playerID: playerID);
                    self.viewController.updatePlayersList();
                }
            }
        }
    }
    
    func getallplayers(gameID: String){
        socket.emit("allplayers", gameID);
    }
    
    func userExit(playerID: String, gameID: String){
        socket.emit("playerexit", [playerID, gameID])
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
    
    func endGame(gameID: String){
        socket.emit("endgame", gameID);
    }
    
    func updateUserLevel(username: String, level: String, level_status: String){
        socket.emit("update_level", [username, level, level_status])
    }

    func updateTaps(gameID: String, playerID: String, taps: String){
        socket.emit("update_taps", [gameID, playerID, taps])
    }
    
    func closeSocket(){
        self.socket.disconnect();
    }
}
