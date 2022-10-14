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
                        Text((dayWeather.date.isToday ? "Today" : dayWeather.date.dayOfWeek).localize(.date))
                            .frame(width: 80, alignment: .leading)
                        Spacer()
                        VStack {
                            // Checks for existense of filled version of the symbol
                            // because some symbols such as "wind" aren't filled.
                            Image(systemName: "\(dayWeather.symbolName)\(dayWeather.symbolName.hasFill() ? ".fill" : "")")
                                .font(.title3)
                                .symbolRenderingMode(.multicolor)
                            if dayWeather.precipitationChance >= 0.3 {
                                Text((round(dayWeather.precipitationChance * 10) / 10.0).formatted(.percent))
                                    .font(.caption2)
                                    .foregroundColor(.cyan)
                            }
                        }
                        Spacer()
                        HStack {
                            Text("\(dayWeather.lowTemperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                                .font(.system(size: 20))

                                .foregroundColor(.secondary)
                            TempGradient(low: dayWeather.lowTemperature,
                                         high: dayWeather.highTemperature)
                                .frame(width: 90, height: 4)
                            Text("\(dayWeather.highTemperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
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
