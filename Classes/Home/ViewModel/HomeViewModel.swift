//
//  HomeViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct HomeViewModel {

    enum ViewModelType {
        case loading
        case videoLargeSection(VideoSectionViewModel)
        case videoDefaultSection(VideoSectionViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([VideoFeedSection])
        case failed(Error)
    }

    let viewModels: [ViewModelType]
    let state: State

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            viewModels = []
        case .loading:
            viewModels = [
                .loading,
            ]
        case .loaded(let sections):
            var innerViewModels: [ViewModelType] = []
            for section in sections {
                let sectionViewModel = VideoSectionViewModel(with: section)
                switch section.type {
                case .large:
                    innerViewModels.append(.videoLargeSection(sectionViewModel))
                case .default:
                    innerViewModels.append(.videoDefaultSection(sectionViewModel))
                }
            }
            viewModels = innerViewModels
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            viewModels = [
                .failure(errorViewModel),
            ]
        }
    }
}

extension HomeViewModel {

    var numberOfItems: Int {
        return viewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
