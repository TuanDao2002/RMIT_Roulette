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

let mockUsers = [
    User(username: "Hello world:)))", yourMoney: 0, highScore: 900000, badge: Badge.legend),
    User(username: "asdf", yourMoney: 0, highScore: 3000, badge: Badge.pro),
    User(username: "a23e", yourMoney: 0, highScore: 1000, badge: Badge.pro),
    User(username: "23!d", yourMoney: 0,  highScore: 5200, badge: Badge.master),
    User(username: "player", yourMoney: 0, highScore: 100, badge: .empty),
    User(username: "dd", yourMoney: 0, highScore: 10000, badge: Badge.legend),
    User(username: "tun", yourMoney: 0, highScore: 1000, badge: Badge.pro),
    User(username: "kha", yourMoney: 0, highScore: 990, badge: .empty),
    User(username: "fdffd", yourMoney: 0, highScore: 100, badge: .empty),
]

// View Model for users
final class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        // populate UserDefault with mock data
//        for user in mockUsers {
//            self.add(newUser: user)
//        }
        
        load()
    }
    
    // load data of users from UserDefault
    func load() {
        if let data = UserDefaults.standard.value(forKey: "users") as? Data {
            self.users = try! PropertyListDecoder().decode(Array<User>.self, from: data)
        }
    }
    
    // add new user
    func add(newUser: User) {
        users.append(newUser)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "users")
    }
    
    // get the current user playing the game
    func getCurrentUser() -> User {
        if (users.count == 0) { return User(username: "", yourMoney: 0, highScore: -1, badge: .empty)}
        let lastIndex = users.count - 1
        return users[lastIndex]
    }
    
    // update the information of the current user
    func updateCurrentUser(yourMoney: Int, highScore: Int, badge: Badge) {
        users[users.count - 1] = User(username: getCurrentUser().username, yourMoney: yourMoney, highScore: highScore, badge: badge)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "users")
    }
    
    // sort the users based on the high scores descending
    func returnSorted() -> [User] {
        return users.sorted {$0.highScore > $1.highScore}
    }
}
