//
//  User.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct User: Decodable {

    enum `Type`: Equatable {
        case bot
        case user(String)
    }

    let type: `Type`
    static let botId = "bot"

    enum CodingKeys: String, CodingKey {
        case id
    }

    init(with type: Type) {
        self.type = type
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(String.self, forKey: .id)
        switch id {
        case User.botId:
            self.type = .bot
        default:
            self.type = .user(id)
        }
    }
}
