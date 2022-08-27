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
                    .frame(height: 20)
            } placeholder: {}
            
            Button {
                onTap()
            } label: {
                Text("Other data sources")
            }
        }
    }
}

//struct AttributionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttributionView(attribution: WeatherAttribution())
//    }
//}
