//
//  HourlyView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct HourlyView: View {
    let forecast: Forecast<HourWeather>
    
    // We only need 25 hours of hourly data starting
    // at the current hour
    var hourlyWeatherData: [HourWeather] {
        return Array(forecast.forecast.filter { hourlyWeather in
            hourlyWeather.date.timeIntervalSince(Date()) >= -3600
        }.prefix(25))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(hourlyWeatherData, id: \.date) { hourWeather in
                    VStack(spacing: 0) {
                        Text(hourWeather.date.hourOfDay().localize())
                            .font(Font.custom("SofiaProLight", size: 17))
                        VStack {
                            Image(systemName: hourWeather.symbolName)
                                .font(.title3)
                            if hourWeather.precipitationChance >= 0.3 {
                                Text("\(((round(hourWeather.precipitationChance * 10) / 10.0) * 100).roundDouble())%")
                                    .font(Font.custom("SofiaProLight", size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(height: 50)
                        
                        Text("\(hourWeather.temperature.converted(to: .fahrenheit).value.roundDouble())°")
                            .font(Font.custom("SofiaProLight", size: 20))
                    }
                }
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView(forecast: Weather.sample.hourlyForecast)
            .previewDisplayName("Light")
        HourlyView(forecast: Weather.sample.hourlyForecast)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
