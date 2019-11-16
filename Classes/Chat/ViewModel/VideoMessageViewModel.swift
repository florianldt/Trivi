//
//  VideoMessageViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct VideoMessageViewModel {
    let id: String
    let user: User
    let text: String
    let videoId: String
    let videoTitle: String
}

extension VideoMessageViewModel {

    static func from(_ message: VideoMessage) -> VideoMessageViewModel {
        return VideoMessageViewModel(id: message.id,
                                    user: message.user,
                                    text: message.text,
                                    videoId: toQNAMetadataParser(message.videoId),
                                    videoTitle: toQNAMetadataParser(message.videoTitle))
    }
}
