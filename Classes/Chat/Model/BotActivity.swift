//
//  BotActivity.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct BotActivity: Decodable {
    let type: String
    let channelId: String
    let id: String
    let text: String
}
