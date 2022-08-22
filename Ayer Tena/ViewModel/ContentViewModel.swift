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
            weather = try await service.getWeather(latitude: latitude, longitude: longitude)
            print("We have weather data!!")
        } catch {
            print("Error getting weather")
        }
        
        isLoading = false
    }
}
