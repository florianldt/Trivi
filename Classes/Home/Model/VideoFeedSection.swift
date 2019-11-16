//
//  VideoFeedSection.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct VideoFeedSection: Decodable {

    enum `Type`: Int, Decodable {
        case large
        case `default`
    }
    let id: Int
    let type: `Type`
    let title: String
    let videos: [Video]
}
