//
//  LetterViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct LetterViewModel {

    struct UserViewModel {
        let id: String
        let avatar: String
        let isVerified: Bool
        let name: String
        let isOnline: Bool
        let languages: [String]
        let headline: String
        let ratingImageName: String
    }

    let id: String
    let title: String
    let message: String
    let videoId: String?
    let videoPoster: URL?
    let videoTitle: String?
    let user: UserViewModel
    let sentAt: String
}

extension LetterViewModel {

    static func from(_ letters: [Letter]) -> [LetterViewModel] {
        return letters
            .map {
                let userViewModel = UserViewModel(id: $0.user.id,
                                                  avatar: $0.user.avatar,
                                                  isVerified: $0.user.isVerified,
                                                  name: $0.user.name,
                                                  isOnline: $0.user.isOnline,
                                                  languages: $0.user.languages,
                                                  headline: $0.user.headline,
                                                  ratingImageName: String(format: "rating_%i", $0.user.rating))
                let stringUrl: String? = $0.videoId != nil ? String(format: "https://img.youtube.com/vi/%@/hqdefault.jpg", $0.videoId!) : nil
                return LetterViewModel(id: $0.id,
                                       title: $0.title,
                                       message: $0.message,
                                       videoId: $0.videoId,
                                       videoPoster: stringUrl != nil ? URL(string: stringUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) : nil,
                                       videoTitle: $0.videoTitle,
                                       user: userViewModel,
                                       sentAt: $0.sentAt.letterFormat)
        }
    }
}
