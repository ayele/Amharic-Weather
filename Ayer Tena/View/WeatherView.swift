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
                            if let alerts = weather.weatherAlerts,
                                !alerts.isEmpty,
                                weather.availability.alertAvailability == .available {
                                AlertView(alerts: alerts) {
                                    weatherVM.url = alerts.first?.detailsURL
                                    weatherVM.isPresentingSafariView = true
                                }
                            }
                            
                            HourlyView(forecast: weather.hourlyForecast)
                            DailyView(forecast: weather.dailyForecast)
                        }
                        
                        if let attribution = weatherVM.attribution {
                            AttributionView(attribution: attribution) {
                                weatherVM.url = attribution.legalPageURL
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
            if let url = weatherVM.url {
                SafariView(url: url)
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView(weatherVM: WeatherViewModel(location: CLLocation(),
                                                    service: WeatherService(),
                                                    weather: Weather.sample))
            WeatherView(weatherVM: WeatherViewModel(location: CLLocation(),
                                                    service: WeatherService(),
                                                    weather: Weather.sample))
                .preferredColorScheme(.dark)
        }
    }
}
