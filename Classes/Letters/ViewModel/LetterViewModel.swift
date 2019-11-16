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
        let avatar: URL?
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
    let user: UserViewModel
    let sentAt: String
}

extension LetterViewModel {

    static func from(_ letters: [Letter]) -> [LetterViewModel] {
        return letters
            .map {
                let userViewModel = UserViewModel(id: $0.user.id,
                                                  avatar: URL(string: $0.user.avatar),
                                                  isVerified: $0.user.isVerified,
                                                  name: $0.user.name,
                                                  isOnline: $0.user.isOnline,
                                                  languages: $0.user.languages,
                                                  headline: $0.user.headline,
                                                  ratingImageName: String(format: "rating_%i", $0.user.rating))
                return LetterViewModel(id: $0.id,
                                       title: $0.title,
                                       message: $0.message,
                                       user: userViewModel,
                                       sentAt: $0.sentAt.letterFormat)
        }
    }
}
