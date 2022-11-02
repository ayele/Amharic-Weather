//
//  AttributionView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct AttributionView: View {
    let attribution: WeatherAttribution
    let onTap: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack {
            AsyncImage(url: colorScheme == .dark
                       ? attribution.combinedMarkDarkURL
                       : attribution.combinedMarkLightURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
                    .controlSize(.mini)
            }
            .frame(height: 20)
            
            Button {
                onTap()
            } label: {
                Text("Other data sources")
                    .foregroundColor(.secondary)
                    .underline()
            }
        }
        .font(.footnote)
    }
}

//struct AttributionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttributionView(attribution: WeatherAttribution())
//    }
//}
