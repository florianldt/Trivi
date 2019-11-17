//
//  Mentor.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct Mentor: Decodable {
    let id: String
    let avatar: String
    let name: String
    let description: String
    let languages: [String]
    let rating: Int
    let isVerified: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case name
        case description
        case languages
        case rating
        case isVerified = "is_verified"
    }
}
