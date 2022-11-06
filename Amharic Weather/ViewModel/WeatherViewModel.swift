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
class WeatherViewModel: NSObject, ObservableObject {
    @Published private(set) var weather: Weather?
    @Published private(set) var city: String?
    @Published private(set) var attribution: WeatherAttribution?
    
    @Published var isPresentingSafariView = false
    @Published var isPresentingSettingsView = false 
    @Published private(set) var isLoading = false
    @Published var isShowingAlert = false
    
    @Published private(set) var error: LocalizedError?
    
    @Published private(set) var location: CLLocation?

    private let locationManager = CLLocationManager()
    private let service = WeatherService()
    var url: URL?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    init(weather: Weather? = nil, city: String? = nil) {
        self.weather = weather
        self.city = city
    }
    
    func refresh() {
        print("refreshing...")
        requestLocation()
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    // Filters all avialble alerts and returns
    // ones that are severe or higher
    func weatherAlerts() -> [WeatherAlert] {
        var severeAlerts: Array<WeatherAlert> = []
        
        if let weather, let alerts = weather.weatherAlerts,
            !alerts.isEmpty,
           weather.availability.alertAvailability == .available {
            
            severeAlerts = alerts.filter { alert in
                alert.severity == .severe || alert.severity == .extreme
            }
        }
        return severeAlerts
    }
    
    // The date of the sunrise in the next 24 hrs
    // There's only one sunrise in 24 hrs
    var sunrise: Date? {
        let now = Date()
        let oneDayFromNow = Calendar.current.date(byAdding: .hour, value: 24, to: now)
        
        if let weather {
            let todaysWeather = weather.dailyForecast.first
            let tomorrowsWeather = weather.dailyForecast[1]
            let todaysSunrise = todaysWeather?.sun.sunrise
            let tomorrowsSunrise = tomorrowsWeather.sun.sunrise
            
            // return available sunrise between today and tomorrow
            if let todaysSunrise, let tomorrowsSunrise, let oneDayFromNow {
                if todaysSunrise > now && todaysSunrise < oneDayFromNow {
                    // Today's sunrise hasn't passed yet
                    return todaysSunrise
                } else {
                    // Today's sunrise has passed. return tomorrow's
                    return tomorrowsSunrise
                }
            }
        }
        return nil
    }
    
    // The date of the sunset in the next 24 hrs
    // There's only one sunset in 24 hrs
    var sunset: Date? {
        let now = Date()
        let oneDayFromNow = Calendar.current.date(byAdding: .hour, value: 24, to: now)
        
        if let weather {
            let todaysWeather = weather.dailyForecast.first
            let tomorrowsWeather = weather.dailyForecast[1]
            let todaysSunset = todaysWeather?.sun.sunset
            let tomorrowsSunset = tomorrowsWeather.sun.sunset
            
            // return available sunset between today and tomorrow
            if let todaysSunset, let tomorrowsSunset, let oneDayFromNow {
                if todaysSunset > now && todaysSunset < oneDayFromNow {
                    // Today's sunset hasn't passed yet
                    return todaysSunset
                } else {
                    // Today's sunset has passed. return tomorrow's
                    return tomorrowsSunset
                }
            }
        }
        return nil
    }
    
    // MARK:- Service
    func getWeather(forLocation location: CLLocation) async {
        print("Getting weather...")
        isLoading = true
        
        do {
            // Three network calls are being made here. Wait for all
            // calls to complete before setting the results
            let weatherData = try await service.weather(for: location)
            let placemark = try await CLGeocoder().reverseGeocodeLocation(location)
            
            attribution = try await service.attribution
            city = placemark.first?.locality
            weather = weatherData
        } catch let e as WeatherError {
            error = e
            print("Error getting weather: \(e.localizedDescription)")
        } catch let e {
            error = WeatherError.unknown
            print("Error getting weather: \(e.localizedDescription)")
        }
        
        isLoading = false
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Location manager did change authorization")

        switch manager.authorizationStatus {
          case .restricted, .denied:
            print("Authrization restricted or denied")
             break
          case .authorizedWhenInUse:
            print("When in use authorized. Requesting location...")
            requestLocation()
             break
          case .authorizedAlways:
            print("Always authorized.")
             break
          case .notDetermined:
            print("Authorization status not determined.")
             break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        
        guard let thisLocation = locations.first else { return }
        location = thisLocation
        
        Task {
            await getWeather(forLocation: thisLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
