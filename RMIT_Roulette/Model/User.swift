//
//  User.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 19/08/2022.
//

import Foundation

struct User: Codable, Hashable {
    var username: String
    var highScore: Int
    var badge: Badge
    
    init(username: String, highScore: Int, badge: Badge) {
        self.username = username
        self.highScore = highScore
        self.badge = badge
    }
}
