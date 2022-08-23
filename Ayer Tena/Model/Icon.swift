//
//  Icon.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/22/22.
//

import Foundation

enum Icon: String, Codable {
    case clearSky = "01d"
    case clearSkyNight = "01n"
    case fewClouds = "02d"
    case fewCloudsNight = "02n"
    case scatteredClouds = "03d"
    case scatteredCloudsNight = "03n"
    case brokenClouds = "04d"
    case brokenCloudsNight = "04n"
    case showerRain = "09d"
    case showerRainNight = "09n"
    case rain = "10d"
    case rainNight = "10n"
    case thunderstorm = "11d"
    case thunderstormNight = "11n"
    case snow = "13d"
    case snowNight = "13n"
    case mist = "50d"
    case mistNight = "50n"
    
    var imageName: String {
        switch self {
        case .clearSky:
            return "sun.max.fill"
        case .clearSkyNight:
            return "moon.stars.fill"
        case .fewClouds:
            return "cloud.sun.fill"
        case .fewCloudsNight:
            return "cloud.moon.fill"
        case .scatteredClouds:
            return "cloud.fill"
        case .scatteredCloudsNight:
            return "cloud.fill"
        case .brokenClouds:
            return "smoke.fill"
        case .brokenCloudsNight:
            return "smoke.fill"
        case .showerRain:
            return "cloud.rain.fill"
        case .showerRainNight:
            return "cloud.rain.fill"
        case .rain:
            return "cloud.sun.rain.fill"
        case .rainNight:
            return "cloud.moon.rain.fill"
        case .thunderstorm:
            return "cloud.bolt.fill"
        case .thunderstormNight:
            return "cloud.bolt.fill"
        case .snow:
            return "snowflake"
        case .snowNight:
            return "snowflake"
        case .mist:
            return "aqi.low"
        case .mistNight:
            return "aqi.low"
        }
    }
}
