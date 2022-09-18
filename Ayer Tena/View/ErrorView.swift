//
//  ErrorView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 9/17/22.
//

import SwiftUI
import WeatherKit

struct ErrorView: View {
    let error: LocalizedError
    
    var symbolName: String {
        switch error {
        case WeatherError.permissionDenied:
            return "hand.raised"
        case NetworkError.noInternetConnection:
            return "wifi.slash"
        default:
            return "exclamationmark.triangle"
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: symbolName)
                .font(.system(size: 45))
                .foregroundColor(.secondary)
            
            VStack(spacing: 2) {
                Text(error.errorDescription ?? "")
                    .font(.title2).bold()
                Text("\(error.failureReason ?? "") \(error.recoverySuggestion ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: WeatherError.permissionDenied)
    }
}
