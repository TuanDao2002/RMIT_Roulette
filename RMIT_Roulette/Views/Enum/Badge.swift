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

// enum for achievement badge
enum Badge: Int, Decodable, Encodable {
    case legend = 10000
    case master = 5000
    case pro = 1000
    case empty
}
