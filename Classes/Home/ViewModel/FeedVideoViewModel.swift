//
//  FeedVideoViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct FeedVideoViewModel {
    let id: String
    let cover: URL?
    let title: String
}

extension FeedVideoViewModel {

    static func from(_ videos: [Video]) -> [FeedVideoViewModel] {
        return videos
            .map {
                FeedVideoViewModel(id: $0.id,
                                   cover: URL(string: $0.cover),
                                   title: $0.title)
        }
    }
}
