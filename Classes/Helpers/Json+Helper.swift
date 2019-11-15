//
//  Json+Helper.swift
//  Trivi
//
//  Created by Florian LUDOT on 11/13/19.
//  Copyright © 2019 Florian Ludot. All rights reserved.
//

import Foundation

class Json {

    typealias JsonDecoderOperationCompletion<Value> = ((JsonDecoderOperation<Value>) -> Void)

    enum JsonDecoderOperation<Value> {
        case success(Value)
        case failure(Error)
    }

    enum JsonDecoderError: LocalizedError {
        case fileNotFound(String)
        case decodationFailure(String)
        case corruptedData(String)

        var errorDescrition: String? {
            switch self {
            case .fileNotFound(let filename):
                return String(format: "%@ - Not Found!", filename)
            case .decodationFailure(let filename):
                return String(format: "%@ - Decodation Failure!", filename)
            case .corruptedData(let filename):
                return String(format: "%@ - Corrupted Data!", filename)
            }
        }
    }

    func from<T: Decodable>(_ filename: String, type: T.Type, completionHandler: JsonDecoderOperationCompletion<T>?) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            completionHandler?(.failure(JsonDecoderError.fileNotFound(String(format: "%@.json", filename))))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                let object = try JSONDecoder().decode(type.self, from: data)
                completionHandler?(.success(object))
                return
            } catch {
                print(error)
                completionHandler?(.failure(JsonDecoderError
                    .decodationFailure(String(format: "%@.json",
                                              filename))))
                return
            }
        } catch {
            completionHandler?(.failure(JsonDecoderError
                .corruptedData(String(format: "%@.json",
                                      filename))))
            return
        }
    }

    func from<T: Decodable>(_ filename: String, type: T.Type) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw JsonDecoderError.fileNotFound(String(format: "%@.json", filename))
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                let object = try JSONDecoder().decode(type.self, from: data)
                return object
            } catch {
                throw JsonDecoderError.decodationFailure(String(format: "%@.json", filename))
            }
        } catch {
            throw JsonDecoderError.corruptedData(String(format: "%@.json", filename))
        }
    }
}
