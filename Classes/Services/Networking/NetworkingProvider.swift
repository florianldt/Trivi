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
        static let azure = "http://168.63.74.75/api/v1/"
    }

    enum Ressources {

        case conversations
        case sendActivity(_ conversationId: String)
        case fetchBotActivities(_ conversationId: String, _ watermark: String)
        case video
        case mentors

        var path: String {
            switch self {
            case .conversations: return Endpoint.directLine + "conversations/"
            case .sendActivity(let conversationId): return Ressources.conversations.path + conversationId + "/activities/"
            case .fetchBotActivities(let conversationId, let watermark): return Ressources.sendActivity(conversationId).path + "?watermark=" + watermark
            case .video: return Endpoint.azure + "video/main"
            case .mentors: return Endpoint.azure + "mentors"
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
                completionHandler?(.failure(error))
            }
        }
    }

    func loadVideoFeed(completionHandler: ((NetworkingProviderResultWithValue<[VideoFeedSection]>) -> Void)?) {
        guard let url = URL(string: Ressources.video.path) else {
            completionHandler?(.failure(Error.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let response = response as? HTTPURLResponse else {
                    guard let error = error else {
                        completionHandler?(.failure(Error.somethingWentWrong))
                        return
                    }
                    completionHandler?(.failure(Error.network))
                    return
                }
            print("-- " + response.statusCode.description + " --")
            switch response.statusCode {
            case HttpStatus.success.code:
                do {
                    let videoSections = try JSONDecoder().decode([VideoFeedSection].self, from: data)
                    completionHandler?(.success(videoSections))
                    return
                } catch {
                    print(error)
                    completionHandler?(.failure(Error.somethingWentWrong))
                    return
                }
            default:
                completionHandler?(.failure(Error.somethingWentWrong))
                return
            }
        }.resume()
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

extension NetworkingProvider {

    func createConversation(completionHandler: ((NetworkingProviderResultWithValue<Conversation>) -> Void)?) {
        guard let url = URL(string: Ressources.conversations.path) else {
            completionHandler?(.failure(Error.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(Secrets.botAutorization,
                         forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let response = response as? HTTPURLResponse else {
                    guard let error = error else {
                        completionHandler?(.failure(Error.somethingWentWrong))
                        return
                    }
                    completionHandler?(.failure(Error.network))
                    return
                }
            print("-- " + response.statusCode.description + " --")
            switch response.statusCode {
            case HttpStatus.created.code:
                do {
                    let conversation = try JSONDecoder().decode(Conversation.self, from: data)
                    completionHandler?(.success(conversation))
                    return
                } catch {
                    print(error)
                    completionHandler?(.failure(Error.somethingWentWrong))
                    return
                }
            default:
                completionHandler?(.failure(Error.somethingWentWrong))
                return
            }
        }.resume()
    }

    func sendActivity(conversation: Conversation,
                      userRequest: UserActivityRequest,
                      completionHandler: ((NetworkingProviderResultWithValue<UserActivityResponse>) -> Void)?) {
        guard let url = URL(string: Ressources.sendActivity(conversation.id).path) else {
            completionHandler?(.failure(Error.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(Secrets.botAutorization,
                         forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userRequest.asData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let response = response as? HTTPURLResponse else {
                    guard let error = error else {
                        completionHandler?(.failure(Error.somethingWentWrong))
                        return
                    }
                    completionHandler?(.failure(Error.network))
                    return
                }

            switch response.statusCode {
            case HttpStatus.success.code:
                do {
                    let response = try JSONDecoder().decode(UserActivityResponse.self, from: data)
                    completionHandler?(.success(response))
                    return
                } catch {
                    print(error.localizedDescription)
                    completionHandler?(.failure(Error.somethingWentWrong))
                    return
                }
            default: completionHandler?(.failure(Error.somethingWentWrong))
            }
        }.resume()
    }

    func fetchBotActivities(conversation: Conversation,
                            watermark: String,
                            completionHandler: ((NetworkingProviderResultWithValue<BotMessage>) -> Void)?) {
        guard let url = URL(string: Ressources.fetchBotActivities(conversation.id, watermark).path) else {
                completionHandler?(.failure(Error.invalidURL))
                return
            }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(Secrets.botAutorization,
                         forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let response = response as? HTTPURLResponse else {
                    guard let error = error else {
                        completionHandler?(.failure(Error.somethingWentWrong))
                        return
                    }
                    completionHandler?(.failure(Error.network))
                    return
                }
            print(response.statusCode)

            switch response.statusCode {
            case HttpStatus.success.code:
                do {
                    let response = try JSONDecoder().decode(BotMessage.self, from: data)
                    completionHandler?(.success(response))
                    return
                } catch {
                    print(error)
                    completionHandler?(.failure(Error.somethingWentWrong))
                    return
                }
            default: completionHandler?(.failure(Error.somethingWentWrong))
            }
        }.resume()
    }
}
