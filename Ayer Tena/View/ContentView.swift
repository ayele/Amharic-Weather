//
//  ContentView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/20/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var contentVM = ContentViewModel(service: WeatherService())

    var body: some View {
        Group {
            if let location = locationManager.location {
                if let weather = contentVM.weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            await contentVM.getWeather(longitude: location.longitude, latitude: location.latitude)
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
