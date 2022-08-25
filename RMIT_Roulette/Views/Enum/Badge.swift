//
//  Badge.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 20/08/2022.
//

import Foundation

// enum for achievement badge
enum Badge: Int, Decodable, Encodable {
    case legend = 10000
    case master = 5000
    case pro = 1000
    case empty
}
