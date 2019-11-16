//
//  TextMessageViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/14/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct TextMessageViewModel {
    let id: String
    let user: User
    let text: String
}

extension TextMessageViewModel {

    static func from(_ message: TextMessage) -> TextMessageViewModel {
        return TextMessageViewModel(id: message.id,
                                    user: message.user,
                                    text: message.text)
    }
}
