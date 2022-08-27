/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Dao Kha Tuan
  ID: 3877347
  Created  date: 14/08/2022
  Last modified: 27/08/2022
  Acknowledgement: None
*/


import Foundation

// the model for user
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
