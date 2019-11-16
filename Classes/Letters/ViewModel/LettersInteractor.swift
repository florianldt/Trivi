//
//  LettersInteractor.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LettersInteractor {

    let networkingProvider: NetworkingProviderProtocol
    let viewModel: BehaviorRelay<LettersViewModel>

    init(networkingProvider: NetworkingProviderProtocol) {
        self.networkingProvider = networkingProvider
        viewModel = BehaviorRelay(value: .init(with: .initialized))
    }

    func loadLetters() {
        viewModel.accept(.init(with: .loading))
        networkingProvider.loadLetters { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let letters):
                strongSelf.viewModel.accept(.init(with: .loaded(letters)))
            case .failure(let error):
                strongSelf.viewModel.accept(.init(with: .failed(error)))
            }
        }
    }
}
