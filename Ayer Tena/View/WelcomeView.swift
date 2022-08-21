//
//  WelcomeView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to Ayer Tena")
                    .bold()
                    .font(Font.custom("Roboto-Bold", size: 28, relativeTo: .title))
                Text("Please share your current location to get the weather in your area")
                    .padding()
                    .font(Font.custom("Roboto-Regular", size: 17))
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
//                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
        }
    }
}
