//
//  VideoLargeSectionViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct VideoSectionViewModel {

    let title: String
    let viewModels: [FeedVideoViewModel]

    init(with section: VideoFeedSection) {
        self.title = section.title
        viewModels = FeedVideoViewModel.from(section.videos)
    }
}
