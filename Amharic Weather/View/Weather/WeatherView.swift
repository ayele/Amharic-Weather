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
    @EnvironmentObject var weatherVM: WeatherViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var rotationAngle = 0.0

    var body: some View {
        Group {
            if let weather = weatherVM.weather {
                GeometryReader { geometry in
                    ZStack(alignment: .topTrailing) {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 15) {
                                VStack(spacing: 15) {
                                    Spacer()
                                    
                                    CurrentView(currentWeather: weather.currentWeather,
                                                highTemperature: weather.dailyForecast.first?.highTemperature,
                                                lowTemperature: weather.dailyForecast.first?.lowTemperature,
                                                city: weatherVM.city ?? "--")
                                    .padding(50)
                                    .overlay {
                                        if weatherVM.isLoading {
                                            Circle()
                                                .stroke(style: StrokeStyle(lineWidth: 10, dash: [60, 5]))
                                                .foregroundColor(.secondary)
                                                .opacity(0.2)
                                                .rotationEffect(Angle(degrees: rotationAngle))
                                                .onAppear() {
                                                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                                                        rotationAngle += 360
                                                    }
                                                }
                                        }
                                    }
                                        
                                    Spacer()
                                    /*
                                    if !weatherVM.weatherAlerts().isEmpty {
                                        AlertView(alerts: weatherVM.weatherAlerts())
                                            .onTapGesture {
                                                weatherVM.url = weatherVM.weatherAlerts().first?.detailsURL
                                                weatherVM.isPresentingSafariView = true
                                            }
                                    }
                                     */
                                    
                                    /*
                                    if let minuteForecast = weather.minuteForecast,
                                       weather.availability.minuteAvailability == .available {
                                        MinuteView(forecast: minuteForecast)
                                    }
                                     */
                                    
                                    CardView {
                                        Label("የየሰዓቱ ትንበያ", systemImage: "clock")
                                    } content: {
                                        HourlyView(forecast: weather.hourlyForecast,
                                                   sunrise: weatherVM.sunrise,
                                                   sunset: weatherVM.sunset)
                                    }
                                }
                                .padding(.horizontal)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                
                                CardView {
                                    Label("የ 10 ቀን ትንበያ", systemImage: "calendar")
                                } content: {
                                    DailyView(forecast: weather.dailyForecast)
                                }
                                .padding(.horizontal)
                                
                                GridView(
                                    currentWeather: weather.currentWeather,
                                    precipitation: weather.dailyForecast.first?.precipitationChance,
                                    sunrise: weather.dailyForecast.first?.sun.sunrise,
                                    sunset: weather.dailyForecast.first?.sun.sunset
                                )
                                    .padding(.horizontal)
                                
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
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                        .foregroundColor(.secondary)
                        .padding(30)
                    }
                    .colorScheme(.dark)
                }
                .background(LinearGradient.sky)
                
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
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                print("scene phase change to active...")
                
                weatherVM.refresh()
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
                        }
                    }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static let weatherVM = WeatherViewModel(weather: Weather.preview, city: "Middleton")
    
    static var previews: some View {
        Group {
            WeatherView()
                .environmentObject(weatherVM)
                .previewDisplayName("Light")
            WeatherView()
                .environmentObject(weatherVM)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
    }
}
