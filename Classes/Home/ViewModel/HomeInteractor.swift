//
//  HomeInteractor.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeInteractor {

    let networkingProvider: NetworkingProviderProtocol
    let viewModel: BehaviorRelay<HomeViewModel>

    init(networkingProvider: NetworkingProviderProtocol) {
        self.networkingProvider = networkingProvider
        viewModel = BehaviorRelay(value: .init(with: .initialized))
    }

    func loadVideoFeed() {
        viewModel.accept(.init(with: .loading))
        networkingProvider.loadVideoFeed { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let sections):
                strongSelf.viewModel.accept(.init(with: .loaded(sections)))
            case .failure(let error):
                strongSelf.viewModel.accept(.init(with: .failed(error)))
            }
        }
    }
}
