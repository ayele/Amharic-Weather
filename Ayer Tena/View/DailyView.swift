//
//  DailyView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct DailyView: View {
    let dailyForecast: [DayWeather]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(dailyForecast, id: \.date) { dayWeather in
                VStack {
                    HStack {
                        Text("\(dayWeather.date.dayOfWeek())")
                            .frame(width: 80, alignment: .leading)
                        Spacer()
                        VStack {
                            Image(systemName: dayWeather.symbolName)
                                .font(.title3)
                            if dayWeather.precipitationChance >= 0.3 {
                                Text("\((dayWeather.precipitationChance * 100).roundDouble())%")
                                    .font(Font.custom("SofiaProLight", size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        HStack {
                            Text("\(dayWeather.lowTemperature.converted(to: UnitTemperature.fahrenheit).value.roundDouble())°")
                                .font(Font.custom("SofiaProLight", size: 20))
                                .foregroundColor(.secondary)
                            Capsule()
                                .frame(width: 90, height: 6)
                                .foregroundColor(.secondary)
                            Text("\(dayWeather.highTemperature.converted(to: UnitTemperature.fahrenheit).value.roundDouble())°")
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

//struct DailyView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyView()
//    }
//}
