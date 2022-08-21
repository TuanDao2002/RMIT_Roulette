//
//  RouletteSectors.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 21/08/2022.
//

import Foundation

struct Sector: Equatable, Hashable {
    var number: Int
    let color: ColorRoulette
}

class RouletteSectors {
    class func get() -> [Sector] {
        return  [Sector(number: 32, color: .red),
                 Sector(number: 15, color: .black),
                 Sector(number: 19, color: .red),
                 Sector(number: 4, color: .black),
                 Sector(number: 21, color: .red),
                 Sector(number: 2, color: .black),
                 Sector(number: 25, color: .red),
                 Sector(number: 17, color: .black),
                 Sector(number: 34, color: .red),
                 Sector(number: 6, color: .black),
                 Sector(number: 27, color: .red),
                 Sector(number: 13, color: .black),
                 Sector(number: 36, color: .red),
                 Sector(number: 11, color: .black),
                 Sector(number: 30, color: .red),
                 Sector(number: 8, color: .black),
                 Sector(number: 23, color: .red),
                 Sector(number: 10, color: .black),
                 Sector(number: 5, color: .red),
                 Sector(number: 24, color: .black),
                 Sector(number: 16, color: .red),
                 Sector(number: 33, color: .black),
                 Sector(number: 1, color: .red),
                 Sector(number: 20, color: .black),
                 Sector(number: 14, color: .red),
                 Sector(number: 31, color: .black),
                 Sector(number: 9, color: .red),
                 Sector(number: 22, color: .black),
                 Sector(number: 18, color: .red),
                 Sector(number: 29, color: .black),
                 Sector(number: 7, color: .red),
                 Sector(number: 28, color: .black),
                 Sector(number: 12, color: .red),
                 Sector(number: 35, color: .black),
                 Sector(number: 3, color: .red),
                 Sector(number: 26, color: .black),
                 Sector(number: 0, color: .green)]
    }
}
