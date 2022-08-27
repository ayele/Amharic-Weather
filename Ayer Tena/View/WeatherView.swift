//
//  WeatherView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct WeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if let weather = weatherVM.weather {
                ScrollView(showsIndicators: false) {
                    VStack {
                        CurrentView(weather: weather, city: weatherVM.city ?? "--")
                        
                        VStack(spacing: 15) {
                            HourlyView(hourlyForecast: weather.hourlyForecast.forecast)
                            DailyView(dailyForecast: weather.dailyForecast.forecast)
                        }
                    }
                    
                }
                .padding()
                .background(Color("SmokeyWhite"))
                
            } else {
                if weatherVM.isLoading {
                    LoadingView()
                } else {
                    Text("")
                }
            }
        }
        .task {
            await weatherVM.getWeather()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                Task {
                    await weatherVM.getWeather()
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView(weatherVM: WeatherViewModel(location: CLLocationCoordinate2D(),
                                                    service: WeatherService()))
            WeatherView(weatherVM: WeatherViewModel(location: CLLocationCoordinate2D(),
                                                    service: WeatherService()))
                .preferredColorScheme(.dark)
        }
    }
}

struct CurrentView: View {
    let weather: Weather
    let city: String
    
    var body: some View {
        VStack(spacing: -5) {
            Text(city)
                .font(Font.custom("SofiaProLight", size: 35))
                .padding(.bottom, 10)
            Text("\(weather.currentWeather.temperature.converted(to: UnitTemperature.fahrenheit).value.roundDouble())°")
                .font(Font.custom("SofiaProLight", size: 90))
                .padding(.leading, 30) // offsets the ° symbol
            Text("\(weather.currentWeather.condition.description)")
                .font(Font.custom("SofiaProLight", size: 20))
        }
        .padding(40)
    }
}

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
                                Text("\((hourWeather.precipitationChance * 100).roundDouble())%")
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
