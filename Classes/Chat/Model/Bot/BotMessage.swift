//
//  BotMessage.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct BotMessage: Decodable {
    let activities: [BotActivity]
    let watermark: String
}
