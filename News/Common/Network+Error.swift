//
//  Network+Error.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case badRequest
    case noData
    case failedToParseData
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
        default:
            return "Something went wrong"
        }
    }
}
