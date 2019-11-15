//
//  MentorsViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import UIKit

struct MentorsViewModel {

    enum ViewModelType {
        case loading
        case mentor(MentorViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([Mentor])
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
        case .loaded(let mentors):
            viewModels = MentorViewModel.from(mentors).map(ViewModelType.mentor)
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            viewModels = [
                .failure(errorViewModel),
            ]
        }
    }
}

extension MentorsViewModel {

    var numberOfItems: Int {
        return viewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }

    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        let returnSize: CGSize
        let cellViewModelType = cellViewModel(at: indexPath)
        switch cellViewModelType {
        case .mentor(let viewModel):
            let itemWidth: CGFloat = (Styles.Sizes.screenW - 24) / 2 - 20
            let itemHeight: CGFloat = itemWidth + 6 + 17 + 7 + viewModel.descriptionHeight + 13 + 14 + 20
            print(viewModel.descriptionHeight)
            returnSize = CGSize(width: itemWidth, height: itemHeight)
            print(returnSize)
        case .loading:
            returnSize = CGSize(width: Styles.Sizes.screenW, height: 60)
        case .failure:
            returnSize = CGSize(width: Styles.Sizes.screenW, height: 76)
        }
        return returnSize
    }
}
