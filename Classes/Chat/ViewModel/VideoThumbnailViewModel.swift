//
//  VideoThumbnailViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/16/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

struct VideoThumbnailViewModel {

    let id: String
    let poster: URL
    let title: String

    init(id: String, title: String) {
        self.id = id
        let stringUrl = String(format: "https://img.youtube.com/vi/%@/hqdefault.jpg", id)
        self.poster = URL(string: stringUrl)!
        self.title = title
    }
}
