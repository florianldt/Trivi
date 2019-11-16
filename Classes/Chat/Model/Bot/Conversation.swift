//
//  Conversation.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/16/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

import Foundation

struct Conversation: Codable {
    let id: String
    let token: String
    let expireIn: Int
    let streamUrl: String
    let referenceGrammarId: String

    enum CodingKeys: String, CodingKey {
        case id = "conversationId"
        case token
        case expireIn = "expires_in"
        case streamUrl
        case referenceGrammarId
    }
}
