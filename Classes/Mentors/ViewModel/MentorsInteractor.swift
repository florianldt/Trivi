//
//  MentorsInteractor.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MentorsInteractor {

    let networkingProvider: NetworkingProviderProtocol
    let viewModel: BehaviorRelay<MentorsViewModel>

    init(networkingProvider: NetworkingProviderProtocol) {
        self.networkingProvider = networkingProvider
        self.viewModel = BehaviorRelay(value: .init(with: .initialized))
    }

    func loadMentors() {
        viewModel.accept(.init(with: .loading))
        networkingProvider.loadMentors { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let mentors):
                strongSelf.viewModel.accept(.init(with: .loaded(mentors)))
            case .failure(let error):
                print(error.localizedDescription)
                strongSelf.viewModel.accept(.init(with: .failed(error)))
            }
        }
    }
}
