//
//  UserActivity.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/16/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct UserActivityRequest: Encodable {
    let type: String
    let from: ActivityUser
    let text: String
}

extension UserActivityRequest {

    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}

struct ActivityUser: Codable {
    let id: String
}

struct UserActivityResponse: Decodable {
    let id: String
}
