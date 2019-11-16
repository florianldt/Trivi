//
//  Message.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

protocol Message: Decodable {
    static var type: MessageType { get }
    var id: String { get }
    var user: User { get}
    var timestamp: String { get }
}

struct TextMessage: Message {
    static var type: MessageType = .text
    var id: String
    var user: User
    var timestamp: String
    let text: String
}

struct VideoMessage: Message {
    static var type: MessageType = .video
    var id: String
    var user: User
    var timestamp: String
    let text: String
    let videoId: String
    let videoTitle: String
}
