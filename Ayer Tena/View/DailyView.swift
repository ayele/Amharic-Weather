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
                        Text(dayWeather.date.dayOfWeek().localize(.date))
                            .frame(width: 80, alignment: .leading)
                        Spacer()
                        VStack {
                            Image(systemName: dayWeather.symbolName)
                                .font(.title3)
                            if dayWeather.precipitationChance >= 0.3 {
                                Text("\(((round(dayWeather.precipitationChance * 10) / 10.0) * 100).roundDouble())%")
                                    .font(.caption2)
                                    .foregroundColor(.cyan)
                            }
                        }
                        Spacer()
                        HStack {
                            Text("\(dayWeather.lowTemperature.converted(to: .fahrenheit).value.roundDouble())°")
                                .font(.system(size: 20))

                                .foregroundColor(.secondary)
                            TempGradient(low: dayWeather.lowTemperature,
                                         high: dayWeather.highTemperature)
                                .frame(width: 90, height: 4)
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
            DailyView(forecast: Weather.preview.dailyForecast)
                .previewDisplayName("Light")
            DailyView(forecast: Weather.preview.dailyForecast)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
