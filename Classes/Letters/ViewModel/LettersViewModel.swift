//
//  LettersViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/15/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct LettersViewModel {

    enum ViewModelType {
        case loading
        case letter(LetterViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([Letter])
        case failed(Error)
    }

    let state: State
    let viewModels: [ViewModelType]

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            viewModels = []
        case .loading:
            viewModels = [
                .loading,
            ]
        case .loaded(let letters):
            viewModels = LetterViewModel.from(letters).map(ViewModelType.letter)
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            viewModels = [
                .failure(errorViewModel),
            ]
        }
    }
}

extension LettersViewModel {

    var numberOfItems: Int {
        return viewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
