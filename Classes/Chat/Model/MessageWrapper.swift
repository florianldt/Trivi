//
//  MessageWrapper.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

enum MessageWrapper: Decodable {

    enum CodingKeys: String, CodingKey {
        case type
    }

    case text(TextMessage)
    case video(VideoMessage)

    var item: Message {
        switch self {
        case .text(let item): return item
        case .video(let item): return item
        }
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(Int.self, forKey: .type)
        switch type {
        case MessageType.text.rawValue: self = .text(try TextMessage(from: decoder))
        case MessageType.video.rawValue: self = .video(try VideoMessage(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type,
                                                   in: values,
                                                   debugDescription: "Invalid type")
        }
    }
}
