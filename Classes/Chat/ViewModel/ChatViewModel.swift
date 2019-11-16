//
//  ChatViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct ChatViewModel {

    enum ViewModelType {
        case loading
        case text(TextMessageViewModel)
        case video(VideoMessageViewModel)
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([Message])
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
        case .loaded(let messages):
            var innerViewModels: [ViewModelType] = []
            for message in messages {
                if let textMessage = message as? TextMessage {
                    let textMessageViewModel = TextMessageViewModel.from(textMessage)
                    innerViewModels.append(.text(textMessageViewModel))
                } else if let videoMessage = message as? VideoMessage {
                    let videoMessageViewModel = VideoMessageViewModel.from(videoMessage)
                    innerViewModels.append(.video(videoMessageViewModel))
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

extension ChatViewModel {

    var numberOfRows: Int {
        return viewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}
