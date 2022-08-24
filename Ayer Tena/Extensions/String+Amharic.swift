//
//  String+Amharic.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/24/22.
//

import Foundation

extension String {
    func inAmharic() -> String {
        switch self {
        case "Thunderstorm":
            return "ነጎድጓድ"
        case "Drizzle":
            return "ነጠብጣብ"
        case "Rain":
            return "ዝናብ"
        case "Snow":
            return "በረዶ"
        case "Mist":
            return "ጭጋግ"
        case "Smoke":
            return "ጭስ"
        case "Haze":
            return "ጭጋግ"
        case "Dust":
            return "አቧራ"
        case "Fog":
            return "ጭጋግ"
        case "Sand":
            return "አሸዋ"
        case "Ash":
            return "አመድ"
        case "Squall":
            return "ስኳል"
        case "Tornado":
            return "አውሎ ነፋስ"
        case "Clear":
            return "ግልጽ"
        case "Clouds":
            return "ደመና"
        default:
            return "--"
        }
    }
}
