//
//  NetworkingProviderResult.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

enum NetworkingProviderResult {
    case success
    case failure(NetworkingProvider.Error)
}

enum NetworkingProviderResultWithValue<Value> {
    case success(Value)
    case failure(Error)
}
