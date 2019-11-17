//
//  ChatInteractor.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ChatInteractorDelegate: class {
    func showPrompts(_ prompts: [QNAResponse.Prompt])
    func showInput()
}

class ChatInteractor {

    let networkingProvider: NetworkingProviderProtocol
    let viewModel: BehaviorRelay<ChatViewModel>

    var conversation: Conversation?
    weak var delegate: ChatInteractorDelegate?

    init(networkingProvider: NetworkingProviderProtocol) {
        self.networkingProvider = networkingProvider
        viewModel = BehaviorRelay(value: .init(with: .initialized))
    }
}

extension ChatInteractor {

    func createConversation() {
        viewModel.accept(.init(with: .loading))
        networkingProvider.createConversation { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let conversation):
                print(conversation)
                strongSelf.conversation = conversation
                strongSelf.sendMessage(with: Secrets.hiddenMessageIndex == 0 ? "starter0" : "starter1", isHidden: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func sendMessage(with text: String, isHidden: Bool = false) {
        guard let conversation = conversation else { return }
        let request = UserActivityRequest(type: "message",
                                          from: ActivityUser(id: "test"),
                                          text: text)
        networkingProvider.sendActivity(conversation: conversation, userRequest: request) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let response):
                if !isHidden {
                    let user = User(with: .user("flo"))
                    let message = TextMessage(id: UUID().uuidString,
                                              user: user,
                                              timestamp: Date().description,
                                              text: text)
                    var updatedMessages = [Message]()
                    if case .loaded(let messages) = strongSelf.viewModel.value.state {
                        updatedMessages.append(contentsOf: messages)
                    }
                    updatedMessages.append(message)
                    strongSelf.viewModel.accept(.init(with: .loaded(updatedMessages)))
                }
                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + .seconds(isHidden ? 0 : 2)) {
                    strongSelf.fetchBotActivities(for: response.id.watermark, in: conversation)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchBotActivities(for watermark: String,
                            in converation: Conversation) {
        networkingProvider.fetchBotActivities(conversation: converation, watermark: watermark) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                var updatedMessages = [Message]()
                if case .loaded(let messages) = strongSelf.viewModel.value.state {
                    updatedMessages.append(contentsOf: messages)
                }
                if let qnaResponse = response.activities.first?.text.toQNAResponse {
                                        print("-- TRIVI AI \(qnaResponse)")

                    switch qnaResponse.type {
                    case 0: updatedMessages.append(TextMessage(id: "0", user: User(with: .bot), timestamp: "", text: qnaResponse.answer))
                    case 1:
                        var videoId = ""
                        var videoTitle = ""
                        for item in qnaResponse.metadata {
                            switch item.name {
                            case "id":
                                videoId = item.value
                            case "title":
                                videoTitle = item.value
                            default: break
                            }
                        }
                        updatedMessages.append(VideoMessage(id: "vi", user: User(with: .bot), timestamp: "", text: qnaResponse.answer, videoId: videoId, videoTitle: videoTitle))
                    default: break
                    }

                    strongSelf.viewModel.accept(.init(with: .loaded(updatedMessages)))

                    for item in qnaResponse.metadata {
                        if item.name == "typing" {
                            strongSelf.delegate?.showInput()
                        }
                    }
                    if !qnaResponse.context.prompts.isEmpty {
                        strongSelf.delegate?.showPrompts(qnaResponse.context.prompts)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
