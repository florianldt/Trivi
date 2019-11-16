//
//  MentorDetailReviewViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct MentorDetailReviewViewModel {

    let name: String
    let ratingImageName: String
    let text: String
}

extension MentorDetailReviewViewModel {

    static func from(_ reviews: [MentorDetail.Feedback.Reviews.Review]) -> [MentorDetailReviewViewModel] {
        return reviews
            .map {
                MentorDetailReviewViewModel(name: $0.name,
                                            ratingImageName: String(format: "rating_%i", $0.rating),
                                            text: $0.text)
        }
    }
}
