//
//  MentorDetailViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct MentorDetailViewModel {

    enum ViewModelType {
        case loading
        case avatar(URL?)
        case headline(String)
        case ratingLanguages(MentorDetailRatingLanguagesViewModel)
        case separator
        case title(String)
        case text(String)
        case list([String])
        case bio(String)
        case review(MentorDetailReviewViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded(MentorDetail)
        case failed(Error)
    }

    let state: State
    let viewModels: [ViewModelType]
    let isVerified: Bool
    let name: String

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            viewModels = []
            isVerified = false
            name = ""
        case .loading:
            viewModels = [
                .loading,
            ]
            isVerified = false
            name = ""
        case .loaded(let mentor):
            let ratingLanguagesViewModel = MentorDetailRatingLanguagesViewModel.from(mentor)

            var innerViewModels: [ViewModelType] = [
                .avatar(URL(string: mentor.avatar)),
                .headline(mentor.headline),
                .ratingLanguages(ratingLanguagesViewModel),
                .separator,
                .title("Office"),
                .text(mentor.location),
                .title("Professional title"),
                .text(mentor.titles.joined(separator: ", ")),
                .title("Customer groups"),
                .text(mentor.customerGroups.joined(separator: ", ")),
                .title("Therapy Orientation"),
                .list(mentor.therapyOrientation),
                .title("SII qualifications"),
                .text(mentor.siiQualifications.joined(separator: ", ")),
                .separator,
                .bio(mentor.bio),
                .separator,
            ]
            innerViewModels += MentorDetailReviewViewModel.from(mentor.feedback.reviews.items).map(ViewModelType.review)
            viewModels = innerViewModels
            isVerified = mentor.isVerified
            name = mentor.name
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            viewModels = [
                .failure(errorViewModel),
            ]
            isVerified = false
            name = ""
        }
    }
}

extension MentorDetailViewModel {

    var numberOfItems: Int {
        return viewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
