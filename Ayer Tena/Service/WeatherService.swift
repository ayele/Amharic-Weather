//
//  WeatherService.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import Foundation
import CoreLocation

class WeatherService {
    
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Weather {
        let apiKey = "4429f6b5fa654eac8cdaa21a45a49e47"
        let baseURL = "https://api.openweathermap.org"
        let url = "\(baseURL)/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&exclude=minutely&units=imperial"
        
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        print("GET status code: \(statusCode ?? 000)")

        guard statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        return try JSONDecoder().decode(Weather.self, from: data)
    }
}
