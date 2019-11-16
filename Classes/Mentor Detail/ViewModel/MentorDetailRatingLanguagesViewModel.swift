//
//  MentorDetailRatingLanguagesViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct MentorDetailRatingLanguagesViewModel {

    let ratingImageName: String
    let reviewText: String
}

extension MentorDetailRatingLanguagesViewModel {

    static func from(_ feedback: MentorDetail.Feedback) -> MentorDetailRatingLanguagesViewModel {
        return MentorDetailRatingLanguagesViewModel(ratingImageName: String(format: "rating_%i", feedback.rating),
                                                    reviewText: String(format: "%i reviews", feedback.reviews.count))
    }
}
