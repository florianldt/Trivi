//
//  NetworkingProviderProtocol.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

protocol NetworkingProviderProtocol {

    func loadMentors(completionHandler: ((NetworkingProviderResultWithValue<[Mentor]>) -> Void)?)
    func loadMentor(completionHandler: ((NetworkingProviderResultWithValue<MentorDetail>) -> Void)?)
    func loadVideoFeed(completionHandler: ((NetworkingProviderResultWithValue<[VideoFeedSection]>) -> Void)?)

    func loadLetters(completionHandler: ((NetworkingProviderResultWithValue<[Letter]>) -> Void)?)
    func loadSample(_ sample: String) -> BotMessage

    // BOT
    func createConversation(completionHandler: ((NetworkingProviderResultWithValue<Conversation>) -> Void)?)
    func sendActivity(conversation: Conversation,
                      userRequest: UserActivityRequest,
                      completionHandler: ((NetworkingProviderResultWithValue<UserActivityResponse>) -> Void)?)
    func fetchBotActivities(conversation: Conversation,
                            watermark: String,
                            completionHandler: ((NetworkingProviderResultWithValue<BotMessage>) -> Void)?)
}
