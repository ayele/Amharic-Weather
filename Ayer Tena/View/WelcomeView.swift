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
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                
            VStack(spacing: 10) {
                Text("እንኳን ደህና መጡ")
                    .font(.largeTitle)
                Text("ለአከባቢዎ አየር ሁኔታ ሎኬሽኖን ሼር ያድርጉ")
                    .font(.callout)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            Button {
                locationManager.requestAuthorization()
            } label: {
                Label("ሼር", systemImage: "location")
                    .frame(width: 100, height: 40)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(30)
            }
            .buttonStyle(.plain)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SmokeyWhite"))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
                .previewDisplayName("Light")
            WelcomeView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
