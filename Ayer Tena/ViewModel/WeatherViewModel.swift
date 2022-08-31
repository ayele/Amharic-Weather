//
//  WeatherViewModel.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/24/22.
//

import Foundation
import CoreLocation
import WeatherKit

@MainActor
class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather?
    @Published private(set) var city: String?
    @Published private(set) var attribution: WeatherAttribution?
    @Published var isPresentingSafariView = false
    @Published private(set) var isLoading = false
    @Published var isShowingAlert = false
    @Published private(set) var error: WeatherError?
    
    var url: URL?
    
    private let service: WeatherService
    private let location: CLLocation
    
    init(location: CLLocation, service: WeatherService, weather: Weather? = nil, city: String? = nil) {
        self.location = location
        self.service = service
        self.weather = weather
        self.city = city
    }
    
    // MARK:- Service
    func getWeather() async {
        isLoading = true
        
        do {
            // Three network calls are being made here. Wait for all
            // calls to complete before setting the results
            let weatherData = try await service.weather(for: location)
            let placemark = try await CLGeocoder().reverseGeocodeLocation(location)
            
            attribution = try await service.attribution
            city = placemark.first?.locality
            weather = weatherData
        } catch {
            print("Error getting weather")
        }
        
        isLoading = false
    }
}
