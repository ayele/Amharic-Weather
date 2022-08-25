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
    var city: City? = nil
    let current: CurrentWeather
    let hourly: [CurrentWeather]
    let daily: [DailyWeather]
    
    struct CurrentWeather: Codable, Identifiable {
        let id = UUID()
        let time: Date
        let temperature: Double
        let condition: [Condition]
        let chanceOfRain: Double?
        
        enum CodingKeys: String, CodingKey {
            case time = "dt"
            case temperature = "temp"
            case condition = "weather"
            case chanceOfRain = "pop"
        }
    }
    
    struct DailyWeather: Codable, Identifiable {
        let id = UUID()
        let time: Date
        let temperature: Temperature
        let condition: [Condition]
        let chanceOfRain: Double
        
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
            case chanceOfRain = "pop"
        }
    }
    
    struct Condition: Codable {
        let code: Int
        let description: String
        let icon: Icon
        
        enum CodingKeys: String, CodingKey {
            case code = "id"
            case description = "main"
            case icon
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
                                    city: City(name: "Middleton"),
                                    current: CurrentWeather(time: Date(),
                                                            temperature: 76,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                    hourly: [CurrentWeather(time: Date(),
                                                            temperature: 76,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                             CurrentWeather(time: Date.now.addingTimeInterval(3600),
                                                            temperature: 77,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                             CurrentWeather(time: Date.now.addingTimeInterval(3600 * 2),
                                                            temperature: 78,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                             CurrentWeather(time: Date.now.addingTimeInterval(3600 * 3),
                                                            temperature: 79,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                             CurrentWeather(time: Date.now.addingTimeInterval(3600 * 4),
                                                            temperature: 80,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                             CurrentWeather(time: Date.now.addingTimeInterval(3600 * 5),
                                                            temperature: 81,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43),
                                             CurrentWeather(time: Date.now.addingTimeInterval(3600 * 6),
                                                            temperature: 82,
                                                            condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                            chanceOfRain: 0.43)
                                            ],
                                    daily: [DailyWeather(time: Date(),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400 * 2),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400 * 3),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400 * 4),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400 * 5),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400 * 6),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43),
                                            DailyWeather(time: Date.now.addingTimeInterval(86400 * 7),
                                                         temperature: DailyWeather.Temperature(low: 50, high: 80),
                                                         condition: [Condition(code: 800, description: "Clear", icon: .rain)],
                                                         chanceOfRain: 0.43)
                                           ])
}
