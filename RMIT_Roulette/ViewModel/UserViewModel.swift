//
//  UserViewModel.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 21/08/2022.
//

import Foundation

let mockUsers = [
    User(username: "Hello world:)))", highScore: 99999, badge: Badge.legend),
    User(username: "asdf", highScore: 3123, badge: Badge.pro),
    User(username: "a23e", highScore: 1023, badge: Badge.pro),
    User(username: "23!d", highScore: 5123, badge: Badge.master),
    User(username: "player", highScore: 100, badge: .empty),
    User(username: "dd", highScore: 10222, badge: Badge.legend),
    User(username: "tun", highScore: 1001, badge: Badge.pro),
    User(username: "kha", highScore: 932, badge: .empty),
    User(username: "fdffd", highScore: 102, badge: .empty),
]


final class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        // populate UserDefault with mock data
        for user in mockUsers {
            self.add(newUser: user)
        }
        
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.value(forKey: "users") as? Data {
            self.users = try! PropertyListDecoder().decode(Array<User>.self, from: data)
        }
    }
    
    func add(newUser: User) {
        users.append(newUser)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "users")
    }
    
    func getCurrentUser() -> User {
        if (users.count == 0) { return User(username: "", highScore: -1, badge: .empty)}
        let lastIndex = users.count - 1
        return users[lastIndex]
    }
    
    func updateCurrentUser(highScore: Int, badge: Badge) {
        users[users.count - 1] = User(username: getCurrentUser().username, highScore: highScore, badge: badge)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "users")
    }
    
    func returnSorted() -> [User] {
        return users.sorted {$0.highScore > $1.highScore}
    }
}
