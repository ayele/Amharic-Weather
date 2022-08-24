//
//  NetworkError.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/24/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case missingURL
    case decodingError
    case noInternetConnection
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "Unknow Error"
        case .missingURL:
            return "Missing URL"
        case .decodingError:
            return "Decoding Error"
        case .noInternetConnection:
            return "No Internet"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .unknownError:
            return "An unknown error has occured."
        case .missingURL:
            return "No URL found."
        case .decodingError:
            return "An error occured while encoding data."
        case .noInternetConnection:
            return "This app is not connected to the internet."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .unknownError:
            return "Relaunch the app and try again."
        case .missingURL:
            return "Make sure a URL is provided and try again."
        case .decodingError:
            return ""
        case .noInternetConnection:
            return "Check your connection and try again."
        }
    }
}
