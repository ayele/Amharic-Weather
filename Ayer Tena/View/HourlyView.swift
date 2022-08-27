//
//  HourlyView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct HourlyView: View {
    let hourlyForecast: [HourWeather]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                // We only need 24 hrs of data
                ForEach(hourlyForecast, id: \.date) { hourWeather in
                    VStack(spacing: 0) {
                        Text("\(hourWeather.date.hourOfDay())")
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
                        Text("\(hourWeather.temperature.converted(to: UnitTemperature.fahrenheit).value.roundDouble())°")
                            .font(Font.custom("SofiaProLight", size: 20))
                    }
                }
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

//struct HourlyView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourlyView()
//    }
//}
