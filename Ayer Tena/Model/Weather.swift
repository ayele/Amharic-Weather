//
//  Weather.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import Foundation

struct Weather: Codable {
    let longitude: Double
    let latitude: Double
    let current: CurrentWeather
    let hourly: [CurrentWeather]
    let daily: [DailyWeather]
    
    struct CurrentWeather: Codable {
        let time: Date
        let temperature: Double
        let condition: [Condition]
        
        enum CodingKeys: String, CodingKey {
            case time = "dt"
            case temperature = "temp"
            case condition = "weather"
        }
    }
    
    struct DailyWeather: Codable {
        let time: Date
        let temperature: Temperature
        let condition: [Condition]
        
        struct Temperature: Codable {
            let low: Double
            let high: Double
            
            enum CodingKeys: String, CodingKey {
                case low = "min"
                case high = "max"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case time = "dt"
            case temperature = "temp"
            case condition = "weather"
        }
    }
    
    struct Condition: Codable {
        let code: Int
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case code = "id"
            case description = "main"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
        case current
        case hourly
        case daily
    }
}

extension Weather {
    static var sampleData = Weather(longitude: -89.32,
                                    latitude: 43.05,
                                    current: CurrentWeather(time: Date(),
                                                            temperature: 80,
                                                            condition: [Condition(code: 800, description: "Clear")]),
                                    hourly: [CurrentWeather(time: Date(),
                                                            temperature: 80,
                                                            condition: [Condition(code: 800, description: "Clear")]),
                                             CurrentWeather(time: Date(),
                                                            temperature: 80,
                                                            condition: [Condition(code: 800, description: "Clear")]),
                                             CurrentWeather(time: Date(),
                                                            temperature: 80,
                                                            condition: [Condition(code: 800, description: "Clear")]),
                                             CurrentWeather(time: Date(),
                                                            temperature: 80,
                                                            condition: [Condition(code: 800, description: "Clear")])
                                            ],
                                    daily: [DailyWeather(time: Date(),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear")])])
}
