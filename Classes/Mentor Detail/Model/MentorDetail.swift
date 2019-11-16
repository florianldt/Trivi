//
//  MentorDetail.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct MentorDetail: Decodable {

    struct Feedback: Decodable {

        struct Reviews: Decodable {

            struct Review: Decodable {

                let id: String
                let name: String
                let text: String
                let rating: Int
            }

            let count: Int
            let items: [Review]
        }

        let rating: Int
        let reviews: Reviews
    }

    let id: String
    let name: String
    let avatar: String
    let headline: String
    let languages: [String]
    let location: String
    let titles: [String]
    let customerGroups: [String]
    let therapyOrientation: [String]
    let siiQualifications: [String]
    let bio: String
    let feedback: Feedback
    let isVerified: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar
        case headline
        case languages
        case location
        case titles
        case customerGroups = "customer_groups"
        case therapyOrientation = "therapy_orientation"
        case siiQualifications = "sii_qualifications"
        case bio
        case feedback
        case isVerified = "is_verified"
    }
}
