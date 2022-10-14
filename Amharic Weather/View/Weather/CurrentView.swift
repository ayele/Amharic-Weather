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
    
    var belowZero: Bool {
        currentWeather.temperature.converted(to: .fahrenheit).value < 0
    }
    
    var body: some View {
        VStack {
            Text(city.localize(.city))
                .font(.largeTitle)
            Text("\(currentWeather.temperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                .font(.custom("HelveticaNeue-Thin", size: 100))
                .offset(x: belowZero ? -5 : 15)
            
            VStack(spacing: 5) {
                Text("\(currentWeather.condition.description.localize(.condition))")
                
                HStack {
                    if let highTemperature {
                        Text("ከ:\(highTemperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                    }
                    
                    if let lowTemperature {
                        Text("ዝ:\(lowTemperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                    }
                }
            }
        }
        .padding(40)
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentView(currentWeather: Weather.preview.currentWeather,
                        highTemperature: Weather.preview.dailyForecast.first!.highTemperature,
                        lowTemperature: Weather.preview.dailyForecast.first!.lowTemperature,
                        city: "ሚድልተን")
                .previewDisplayName("Light")
            CurrentView(currentWeather: Weather.preview.currentWeather,
                        highTemperature: Weather.preview.dailyForecast.first!.highTemperature,
                        lowTemperature: Weather.preview.dailyForecast.first!.lowTemperature,
                        city: "ሚድልተን")
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
