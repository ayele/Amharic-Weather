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
                        CurrentView(currentWeather: weather.currentWeather,
                                    city: weatherVM.city ?? "--")
                        
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
