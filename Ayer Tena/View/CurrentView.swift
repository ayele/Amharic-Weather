//
//  CurrentView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct CurrentView: View {
    let currentWeather: CurrentWeather
    let city: String
    
    var body: some View {
        VStack(spacing: -5) {
            Text(city.localize())
                .font(.largeTitle)
            Text("\(currentWeather.temperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                .font(.system(size: 100))
                .padding(.leading, 30) // offsets the ° symbol
            Text("\(currentWeather.condition.description.localize())")
        }
        .padding(40)
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView(currentWeather: Weather.sample.currentWeather, city: "ሚድልተን")
            .previewDisplayName("Light")
        CurrentView(currentWeather: Weather.sample.currentWeather, city: "ሚድልተን")
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
