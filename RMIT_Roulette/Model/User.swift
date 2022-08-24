//
//  User.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 19/08/2022.
//

import Foundation

struct User: Codable, Hashable {
    var username: String
    var yourMoney: Int
    var highScore: Int
    var badge: Badge
    
    init(username: String, yourMoney: Int, highScore: Int, badge: Badge) {
        self.username = username
        self.yourMoney = yourMoney
        self.highScore = highScore
        self.badge = badge
    }
}
