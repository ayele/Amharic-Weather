//
//  ContentView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/20/22.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
        Group {
            if let location = locationManager.location {
                WeatherView(
                    weatherVM: WeatherViewModel(
                        location: CLLocation(
                            latitude: location.latitude,
                            longitude: location.longitude),
                        service: WeatherService()
                    )
                )
                
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
