//
//  NetworkError.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 9/17/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case noInternetConnection
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet Connection"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .noInternetConnection:
            return "Ayer Tena isn't connected to the internet."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .noInternetConnection:
            return "Check your connection, then try again."
        }
    }
}
