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

// View Model to return all of the sectors of roulette wheel
class RouletteSectorsViewModel {
    class func get() -> [RouletteSector] {
        return  [RouletteSector(number: 32, color: .red),
                 RouletteSector(number: 15, color: .black),
                 RouletteSector(number: 19, color: .red),
                 RouletteSector(number: 4, color: .black),
                 RouletteSector(number: 21, color: .red),
                 RouletteSector(number: 2, color: .black),
                 RouletteSector(number: 25, color: .red),
                 RouletteSector(number: 17, color: .black),
                 RouletteSector(number: 34, color: .red),
                 RouletteSector(number: 6, color: .black),
                 RouletteSector(number: 27, color: .red),
                 RouletteSector(number: 13, color: .black),
                 RouletteSector(number: 36, color: .red),
                 RouletteSector(number: 11, color: .black),
                 RouletteSector(number: 30, color: .red),
                 RouletteSector(number: 8, color: .black),
                 RouletteSector(number: 23, color: .red),
                 RouletteSector(number: 10, color: .black),
                 RouletteSector(number: 5, color: .red),
                 RouletteSector(number: 24, color: .black),
                 RouletteSector(number: 16, color: .red),
                 RouletteSector(number: 33, color: .black),
                 RouletteSector(number: 1, color: .red),
                 RouletteSector(number: 20, color: .black),
                 RouletteSector(number: 14, color: .red),
                 RouletteSector(number: 31, color: .black),
                 RouletteSector(number: 9, color: .red),
                 RouletteSector(number: 22, color: .black),
                 RouletteSector(number: 18, color: .red),
                 RouletteSector(number: 29, color: .black),
                 RouletteSector(number: 7, color: .red),
                 RouletteSector(number: 28, color: .black),
                 RouletteSector(number: 12, color: .red),
                 RouletteSector(number: 35, color: .black),
                 RouletteSector(number: 3, color: .red),
                 RouletteSector(number: 26, color: .black),
                 RouletteSector(number: 0, color: .green)]
    }
}
