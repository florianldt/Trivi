//
//  ErrorViewModel.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    let description: String
}

extension ErrorViewModel {

    static func from(_ error: Error) -> ErrorViewModel {
        return ErrorViewModel(description: error.localizedDescription)
    }
}
