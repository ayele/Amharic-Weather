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
    let sunrise: Date?
    let sunset: Date?
    
    // We only need 25 hours of hourly data starting
    // at the current hour
    var hourlyWeatherData: [HourWeather] {
        return Array(forecast.forecast.filter { hourlyWeather in
            hourlyWeather.date.timeIntervalSince(Date()) >= -3600
        }.prefix(25))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(hourlyWeatherData, id: \.date) { hourWeather in
                    VStack(spacing: 0) {
                        Text(hourWeather.date.isNow ? "Now".localize(.date) : hourWeather.date.timeOfDay)
                            .font(.system(size: 14))
                        VStack {
                            Image(systemName: hourWeather.symbolName)
                                .font(.title3)
                            // Only show precip. chance if >= 30%
                            if hourWeather.precipitationChance >= 0.3 {
                                // Don't show precip. chance for current hour
                                if let currentHourWeather = hourlyWeatherData.first,
                                   hourWeather != currentHourWeather {
                                    Text("\(((round(hourWeather.precipitationChance * 10) / 10.0) * 100).roundDouble())%")
                                        .font(.caption2)
                                        .foregroundColor(.cyan)
                                }
                            }
                        }
                        .frame(height: 50)
                        
                        Text("\(hourWeather.temperature.converted(to: .fahrenheit).value.roundDouble())°")
                            .font(.system(size: 20))
                    }
                    
                    if let sunrise {
                        if Calendar.current.isDate(sunrise, equalTo: hourWeather.date, toGranularity: .hour) {
                            SunEventView(date: sunrise, type: .sunrise)
                        }
                    }
                    
                    if let sunset {
                        if Calendar.current.isDate(sunset, equalTo: hourWeather.date, toGranularity: .hour) {
                            SunEventView(date: sunset, type: .sunset)
                        }
                    }
                }
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).strokeBorder(.secondary, lineWidth: 1) }
    }
}

struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HourlyView(forecast: Weather.preview.hourlyForecast,
                       sunrise: Date(),
                       sunset: Date())
                .previewDisplayName("Light")
            HourlyView(forecast: Weather.preview.hourlyForecast,
                       sunrise: Date(),
                       sunset: Date())
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}

struct SunEventView: View {
    enum SunEventType {
        case sunrise
        case sunset
    }
    
    let date: Date
    let type: SunEventType
    
    var body: some View {
        VStack(spacing: 0) {
            Text(date.exactTimeOfDay)
                .font(.system(size: 14))
            Image(systemName: type == .sunrise ? "sunrise" : "sunset")
                .font(.title3)
                .frame(height: 50)
            Text(type == .sunrise ? "Sunrise" : "Sunset")
                .font(.system(size: 20))
        }
    }
}
