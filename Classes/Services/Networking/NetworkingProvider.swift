//
//  NetworkingProvider.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

class NetworkingProvider: NetworkingProviderProtocol {

    enum Endpoint {
        static let directLine = "https://directline.botframework.com/v3/directline/"
    }

    enum Ressources {

        case conversations
        case sendActivity(_ conversationId: String)
        case fetchBotActivities(_ conversationId: String, _ watermark: String)

        var path: String {
            switch self {
            case .conversations: return Endpoint.directLine + "conversations/"
            case .sendActivity(let conversationId): return Ressources.conversations.path + conversationId + "/activities/"
            case .fetchBotActivities(let conversationId, let watermark): return Ressources.sendActivity(conversationId).path + "?watermark=" + watermark
            }
        }
    }

    enum HttpStatus: Int {
        case success = 200
        case created = 201
        case notFound = 204
        case authenticationFailure = 401

        var code: Int {
            return self.rawValue
        }
    }

    enum Error: LocalizedError {
        case invalidURL
        case somethingWentWrong
        case network

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .somethingWentWrong: return "Something went wrong.\nPlease retry :)"
            case .network: return "Network error. Try again later please!"
            }
        }
    }

    enum Samples {
        static let normal = "normal"
        static let video = "video"
        static let choice = "choice"
    }
}

extension NetworkingProvider {

    func loadMentors(completionHandler: ((NetworkingProviderResultWithValue<[Mentor]>) -> Void)?) {
        Json().from("mentors", type: [Mentor].self) { result in
            switch result {
            case .success(let mentors):
                completionHandler?(.success(mentors))
            case .failure(let error):
                print(error)
                completionHandler?(.failure(error))
            }
        }
    }

    func loadVideoFeed(completionHandler: ((NetworkingProviderResultWithValue<[VideoFeedSection]>) -> Void)?) {
        Json().from("video_feed", type: [VideoFeedSection].self) { result in
            switch result {
            case .success(let videoFeedSections):
                completionHandler?(.success(videoFeedSections))
            case .failure(let error):
                completionHandler?(.failure(error))
            }
        }
    }

    func loadLetters(completionHandler: ((NetworkingProviderResultWithValue<[Letter]>) -> Void)?) {
        Json().from("letters", type: [Letter].self) { result in
            switch result {
            case .success(let letters):
                completionHandler?(.success(letters))
            case .failure(let error):
                completionHandler?(.failure(error))
            }
        }
    }

    func loadMentor(completionHandler: ((NetworkingProviderResultWithValue<MentorDetail>) -> Void)?) {
        Json().from("mentor", type: MentorDetail.self) { result in
            switch result {
            case .success(let mentor):
                completionHandler?(.success(mentor))
            case .failure(let error):
                completionHandler?(.failure(error))
            }
        }
    }
}

extension NetworkingProvider {
    func loadSample(_ sample: String) -> BotMessage {
        do {
            let botMessage = try Json().from(sample, type: BotMessage.self)
            return botMessage
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
