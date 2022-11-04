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
    @StateObject var weatherVM = WeatherViewModel()

    var body: some View {
        Group {
            if weatherVM.location != nil {
                WeatherView()
                    .environmentObject(weatherVM)
            } else {
                if weatherVM.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(weatherVM)
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
