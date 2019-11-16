//
//  MentorViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

struct MentorViewModel {
    let id: String
    let avatar: URL?
    let name: String
    let description: String
    let descriptionHeight: CGFloat
    let languages: [String]
    let ratingImageName: String
}

extension MentorViewModel {

    static func from(_ mentors: [Mentor]) -> [MentorViewModel] {
        let container: CGFloat = (Styles.Sizes.screenW - 24) / 2 - 24 - 10 - 4
        return mentors
            .map {
                let descriptionHeight = $0.description.height(withConstrainedWidth: container, font: UIFont.systemFont(ofSize: 12, weight: .regular))
                return MentorViewModel(id: $0.id,
                                avatar: URL(string: $0.avatar),
                                name: $0.name,
                                description: $0.description,
                                descriptionHeight: descriptionHeight,
                                languages: $0.languages,
                                ratingImageName: String(format: "rating_%i", $0.rating))
        }
    }
}
