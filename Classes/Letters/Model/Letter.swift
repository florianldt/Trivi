//
//  Letter.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct Letter: Decodable {

    struct User: Decodable {

        let id: String
        let avatar: String
        let name: String
        let languages: [String]
        let headline: String
        let rating: Int
        let isVerified: Bool
        let isOnline: Bool

        enum CodingKeys: String, CodingKey {
            case id
            case avatar
            case name
            case languages
            case headline
            case rating
            case isVerified = "is_verified"
            case isOnline = "is_online"
        }
    }

    let id: String
    let title: String
    let message: String
    let videoId: String?
    let videoTitle: String?
    let user: User
    let sentAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case videoId = "video_id"
        case videoTitle = "video_title"
        case message
        case user
        case sentAt = "sent_at"
    }
}
