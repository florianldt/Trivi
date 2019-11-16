//
//  MentorInteractor.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MentorInteractor {

    let networkingProvider: NetworkingProviderProtocol
    let viewModel: BehaviorRelay<MentorDetailViewModel>

    init(networkingProvider: NetworkingProviderProtocol) {
        self.networkingProvider = networkingProvider
        viewModel = BehaviorRelay(value: .init(with: .initialized))
    }

    func loadMentor() {
        networkingProvider.loadMentor { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let mentor):
                strongSelf.viewModel.accept(.init(with: .loaded(mentor)))
            case .failure(let error):
                strongSelf.viewModel.accept(.init(with: .failed(error)))
            }
        }
    }
}
