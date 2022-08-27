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
    
    // We only need 25 hours of hourly data starting
    // at the current hour
    var hourlyWeatherData: [HourWeather] {
        if let weather = weatherVM.weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                hourlyWeather.date.timeIntervalSince(Date()) >= -3600
            }.prefix(25))
        } else {
            return []
        }
    }
    
    var body: some View {
        Group {
            if let weather = weatherVM.weather {
                ScrollView(showsIndicators: false) {
                    VStack {
                        CurrentView(currentWeather: weather.currentWeather,
                                    city: weatherVM.city ?? "--")
                        
                        VStack(spacing: 15) {
                            HourlyView(hourlyForecast: hourlyWeatherData)
                            DailyView(dailyForecast: weather.dailyForecast.forecast)
                        }
                        
                        if let attribution = weatherVM.attribution {
                            AttributionView(attribution: attribution) {
                                weatherVM.isPresentingSafariView = true
                            }
                                .padding(.top, 80)
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
        .fullScreenCover(isPresented: $weatherVM.isPresentingSafariView) {
            if let attribution = weatherVM.attribution {
                SafariView(url: attribution.legalPageURL)
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
