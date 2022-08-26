//
//  WelcomeView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                
            VStack(spacing: 10) {
                Text("እንኳን ደህና መጡ")
                    .font(.largeTitle)
                Text("ለአከባቢዎ አየር ሁኔታ እባኮን ሎኬሽኖን ሼር ያርጉ")
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestAuthorization()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SmokeyWhite"))

    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
            WelcomeView()
                .preferredColorScheme(.dark)
        }
    }
}
