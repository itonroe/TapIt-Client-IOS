//
//  Room.swift
//  PressIt
//
//  Created by Roe Iton on 14/01/2020.
//  Copyright © 2020 Roe Iton. All rights reserved.
//


class Room{
    
    var roomID: String
    var players: [Player] = []
    
    init (nickname: String, lvl: String, roomID: String, playerID: String){
        self.roomID = roomID
        players.append(Player(nickname: nickname, lvl: lvl, playerID: playerID))
    }

    func getPlayerByIndex(index: Int) -> Player{
        for i in 0...players.count{
            if (i == index) { return players[i]; }
        }
        
        return Player(nickname: "", lvl: "-1", playerID: "");
    }
    
    func add_Player(nickname: String, lvl: String, playerID: String){
        players.append(Player(nickname: nickname, lvl: lvl, playerID: playerID))
    }
    
    func remove_Player(playerID: String){
        players.remove(at: getIndexByPlayer(player_ID: playerID))
    }
    
    func get_NumberOfPlayers() -> Int{
        return players.count;
    }
    
    func getIndexByPlayer(player_ID: String) -> Int{
        
        var i = 0;
        
        for p in players{
            if (p.get_playerID() == player_ID){
                return i;
            }
            i += 1;
        }
        
        return -1;
    }
    
    func sortByTaps() -> Array<Player>{
        var leaderBoard = players;
        
        for i in 0...leaderBoard.count - 1 {
            for j in i...leaderBoard.count - 1 {
                if (leaderBoard[i].get_Taps() < leaderBoard[j].get_Taps()){
                    let temp = leaderBoard[i];
                    leaderBoard[i] = leaderBoard[j];
                    leaderBoard[j] = temp;
                }
            }
        }
        
        return leaderBoard;
    }
}
