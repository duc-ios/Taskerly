//
//  AppError.swift
//  Taskerly
//
//  Created by Duc on 14/8/24.
//

import Foundation

enum AppError: LocalizedError {
    case
        unexpected,
        badRequest,
        network,
        error(Error),
        message(String)

    var errorDescription: String? {
        switch self {
        case .network:
            return "No network"
        default:
            return "Something went wrong"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .unexpected:
            return "Unexpected Error"
        case .badRequest:
            return "Bad Request"
        case .network:
            return "Please try again later."
        case .error(let error):
            if let error = error as? AppError {
                return error.recoverySuggestion
            } else {
                return (error as NSError).description
            }
        case .message(let message):
            return message
        }
    }
}
