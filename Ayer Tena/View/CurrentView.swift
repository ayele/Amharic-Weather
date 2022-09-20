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
    let highTemperature: Measurement<UnitTemperature>?
    let lowTemperature: Measurement<UnitTemperature>?
    let city: String
    
    var body: some View {
        VStack(spacing: -5) {
            Text(city.localize(.city))
                .font(.largeTitle)
            
            Text("\(currentWeather.temperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                .font(.system(size: 100))
                .padding(.leading, 30) // offsets the ° symbol
            
            Text("\(currentWeather.condition.description.localize(.condition))")
            
            HStack {
                Text("ከ:\(highTemperature?.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))) ?? "")°")
                Text("ዝ:\(lowTemperature?.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))) ?? "")°")
            }
            .padding(.top, 10)
        }
        .padding(40)
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentView(currentWeather: Weather.sample.currentWeather,
                        highTemperature: Weather.sample.dailyForecast.first!.highTemperature,
                        lowTemperature: Weather.sample.dailyForecast.first!.lowTemperature,
                        city: "ሚድልተን")
                .previewDisplayName("Light")
            CurrentView(currentWeather: Weather.sample.currentWeather,
                        highTemperature: Weather.sample.dailyForecast.first!.highTemperature,
                        lowTemperature: Weather.sample.dailyForecast.first!.lowTemperature,
                        city: "ሚድልተን")
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
