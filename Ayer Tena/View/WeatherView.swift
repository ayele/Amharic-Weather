//
//  WeatherView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if let weather = weatherVM.weather {
                ScrollView(showsIndicators: false) {
                    VStack {
                        CurrentView(weather: weather)
                        
                        VStack(spacing: 15) {
                            HourlyView(weather: weather)
                            DailyView(weather: weather)
                        }
                    }
                    .padding()
                }
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
        WeatherView(weatherVM: WeatherViewModel(location: CLLocationCoordinate2D(),
                                                service: WeatherService(),
                                                weather: Weather.sampleData))
    }
}

struct CurrentView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: -5) {
            Text("\(weather.city?.name ?? "--")")
                .font(Font.custom("SofiaProLight", size: 35))
                .padding(.bottom, 10)
            Text("\(weather.current.temperature.roundDouble())°")
                .font(Font.custom("SofiaProLight", size: 90))
                .padding(.leading, 30) // offsets the ° symbol
            Text("\(weather.current.condition[0].description.inAmharic())")
                .font(Font.custom("SofiaProLight", size: 20))
        }
        .padding(40)
    }
}

struct HourlyView: View {
    let weather: Weather
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                // We only need 24 hrs of data
                ForEach(weather.hourly.prefix(24)) { hourly in
                    VStack(spacing: 0) {
                        Text("\(hourly.time.hourOfDay())")
                            .font(Font.custom("SofiaProLight", size: 17))
                        VStack {
                            Image(systemName: "\(hourly.condition[0].icon.imageName)")
                                .font(.title3)
                            if let cor = hourly.chanceOfRain, cor > 0 {
                                Text("\((cor * 100).roundDouble())%")
                                    .font(Font.custom("SofiaProLight", size: 15))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(height: 50)
                        Text("\(hourly.temperature.roundDouble())°")
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
    let weather: Weather
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(weather.daily) { daily in
                VStack {
                    HStack {
                        Text("\(daily.time.dayOfWeek())")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        VStack {
                            Image(systemName: "\(daily.condition[0].icon.imageName)")
                                .font(.title3)
                            if daily.chanceOfRain > 0 {
                                Text("\((daily.chanceOfRain * 100).roundDouble())%")
                                    .font(Font.custom("SofiaProLight", size: 15))
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        HStack {
                            Text("\(daily.temperature.low.roundDouble())°")
                                .font(Font.custom("SofiaProLight", size: 20))
                                .foregroundColor(.secondary)
                            Capsule()
                                .frame(width: 90, height: 6)
                                .foregroundColor(.secondary)
                            Text("\(daily.temperature.high.roundDouble())°")
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
