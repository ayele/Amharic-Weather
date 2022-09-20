//
//  DailyView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct DailyView: View {
    let forecast: Forecast<DayWeather>
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(forecast, id: \.date) { dayWeather in
                VStack(spacing: 15) {
                    HStack {
                        Text(dayWeather.date.dayOfWeek().localize())
                            .frame(width: 80, alignment: .leading)
                        Spacer()
                        VStack {
                            Image(systemName: dayWeather.symbolName)
                                .font(.title3)
                                .symbolRenderingMode(.hierarchical)
                            if dayWeather.precipitationChance >= 0.3 {
                                Text("\(((round(dayWeather.precipitationChance * 10) / 10.0) * 100).roundDouble())%")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        HStack {
                            Text("\(dayWeather.lowTemperature.converted(to: .fahrenheit).value.roundDouble())°")
                                .font(.system(size: 20))

                                .foregroundColor(.secondary)
                            TempGradient(low: dayWeather.lowTemperature,
                                         high: dayWeather.highTemperature)
                            Text("\(dayWeather.highTemperature.converted(to: .fahrenheit).value.roundDouble())°")
                                .font(.system(size: 20))

                        }
                        .frame(width: 200, alignment: .trailing)
                    }
                    .frame(height: 25)
                    
                    if dayWeather.date != forecast.last?.date {
                        Divider()
                    }
                   
                }
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).strokeBorder(.secondary, lineWidth: 1) }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DailyView(forecast: Weather.sample.dailyForecast)
                .previewDisplayName("Light")
            DailyView(forecast: Weather.sample.dailyForecast)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
