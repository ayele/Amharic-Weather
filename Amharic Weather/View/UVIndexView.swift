//
//  UVIndexView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/11/22.
//

import SwiftUI
import WeatherKit

struct UVIndexView: View {
    let uvIndex: UVIndex
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(uvIndex.value)")
                .font(.custom("HelveticaNeue-Thin", size: 35))
                .fontWeight(.regular)
            Text("\(uvIndex.category.description.localize(.weather))")
            UVBar(value: uvIndex.value)
                .padding(.vertical)
        }
    }
}

struct UVIndexView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UVIndexView(uvIndex: Weather.preview.currentWeather.uvIndex)
                .previewDisplayName("Light")
            UVIndexView(uvIndex: Weather.preview.currentWeather.uvIndex)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
