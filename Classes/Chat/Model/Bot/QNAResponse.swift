//
//  QNAResponse.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct QNAResponse: Decodable {

    struct Context: Decodable {
        let isContextOnly: Bool
        let prompts: [Prompt]
    }

    struct Prompt: Decodable {
        let displayOrder: Int
        let displayText: String
    }

    struct MetadataItem: Decodable {
        let name: String
        let value: String
    }

    let answer: String
    let context: Context
    let metadata: [MetadataItem]
    let type: Int
}
