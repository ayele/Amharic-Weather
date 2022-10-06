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
                ZStack(alignment: .topTrailing) {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            CurrentView(currentWeather: weather.currentWeather,
                                        highTemperature: weather.dailyForecast.first?.highTemperature,
                                        lowTemperature: weather.dailyForecast.first?.lowTemperature,
                                        city: weatherVM.city ?? "--")
                            
                            VStack(spacing: 15) {
                                if let alerts = weather.weatherAlerts,
                                    !alerts.isEmpty,
                                    weather.availability.alertAvailability == .available {
                                    AlertView(alerts: alerts)
                                        .onTapGesture {
                                            weatherVM.url = alerts.first?.detailsURL
                                            weatherVM.isPresentingSafariView = true
                                        }
                                }
                                
                                if let minuteForecast = weather.minuteForecast,
                                   weather.availability.minuteAvailability == .available {
                                    MinuteView(forecast: minuteForecast)
                                }
                                
                                HourlyView(forecast: weather.hourlyForecast,
                                           sunrise: weatherVM.sunrise,
                                           sunset: weatherVM.sunset)
                                DailyView(forecast: weather.dailyForecast)
                            }
                            
                            if let attribution = weatherVM.attribution {
                                AttributionView(attribution: attribution) {
                                    weatherVM.url = attribution.legalPageURL
                                    weatherVM.isPresentingSafariView = true
                                }
                                    .padding()
                            }
                        }
                    }
                    
                    Button {
                        weatherVM.isPresentingSettingsView = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(Color("SmokeyWhite"))
            } else {
                if weatherVM.isLoading {
                    LoadingView()
                } else {
                    if let error = weatherVM.error {
                        ErrorView(error: error)
                    } else {
                        Spacer()
                    }
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
        .sheet(isPresented: $weatherVM.isPresentingSettingsView) {
            NavigationStack {
                SettingsView()
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                weatherVM.isPresentingSettingsView = false
                            }
                            .buttonStyle(.plain)
                        }
                    }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView(weatherVM: WeatherViewModel(location: CLLocation(),
                                                    service: WeatherService(),
                                                    weather: Weather.preview,
                                                    city: "ሚድልተን"))
                .previewDisplayName("Light")
            WeatherView(weatherVM: WeatherViewModel(location: CLLocation(),
                                                    service: WeatherService(),
                                                    weather: Weather.preview,
                                                    city: "ሚድልተን"))
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
    }
}
