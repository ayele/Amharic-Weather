//
//  WeatherViewModel.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/24/22.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather?
    @Published private(set) var isLoading = false
    @Published var isShowingAlert = false
    @Published private(set) var error: NetworkError?
    
    private let service: WeatherService
    private let location: CLLocationCoordinate2D
    
    init(location: CLLocationCoordinate2D, service: WeatherService, weather: Weather? = nil) {
        self.location = location
        self.service = service
        self.weather = weather
    }
    
    // MARK:- Service
    func getWeather() async {
        isLoading = true
        
        do {
            var weatherNoCity = try await service.getWeather(latitude: location.latitude, longitude: location.longitude)
            let cities = try await service.getCity(latitude: location.latitude, longitude: location.longitude)
            if let city = cities.first {
                weatherNoCity.city = city
            }
            weather = weatherNoCity
            print("We have weather data!!")
        } catch {
            print("Error getting weather")
        }
        
        isLoading = false
    }
}
