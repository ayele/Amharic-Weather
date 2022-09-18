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
            ForEach(forecast.forecast, id: \.date) { dayWeather in
                VStack {
                    HStack {
                        Text(dayWeather.date.dayOfWeek().localize())
                            .frame(width: 80, alignment: .leading)
                        Spacer()
                        VStack {
                            Image(systemName: dayWeather.symbolName)
                                .font(.title3)
                            if dayWeather.precipitationChance >= 0.3 {
                                Text("\(((round(dayWeather.precipitationChance * 10) / 10.0) * 100).roundDouble())%")
                                    .font(Font.custom("SofiaProLight", size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        HStack {
                            Text("\(dayWeather.lowTemperature.converted(to: .fahrenheit).value.roundDouble())°")
                                .font(Font.custom("SofiaProLight", size: 20))
                                .foregroundColor(.secondary)
                            Capsule()
                                .frame(width: 90, height: 6)
                                .foregroundColor(.secondary)
                            Text("\(dayWeather.highTemperature.converted(to: .fahrenheit).value.roundDouble())°")
                                .font(Font.custom("SofiaProLight", size: 20))
                        }
                        .frame(width: 200, alignment: .trailing)
                    }
                    .frame(height: 35)
                    Divider()
                }
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(forecast: Weather.sample.dailyForecast)
            .previewDisplayName("Light")
        DailyView(forecast: Weather.sample.dailyForecast)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
