//
//  ContentViewModel.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import Foundation
import CoreLocation

@MainActor
class ContentViewModel: ObservableObject {
    @Published private(set) var weather: Weather?
    @Published private(set) var isLoading = false
    @Published var isShowingAlert = false
    @Published private(set) var error: LocalizedError?
    
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
    
    // MARK:- Service
    
    func getWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees) async {
        isLoading = true
        
        do {
            var weatherNoCity = try await service.getWeather(latitude: latitude, longitude: longitude)
            let cities = try await service.getCity(latitude: latitude, longitude: longitude)
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
