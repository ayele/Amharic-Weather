//
//  String+Localize.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/30/22.
//

import Foundation

enum LocalizationCategory: String {
    case date = "LocalizableDates"
    case weather = "LocalizableWeather"
    case city = "LocalizableCities"
    case county = "LocalizableCounties"
}

extension String {
    func localize(_ source: LocalizationCategory) -> String {
        // retrieve the cache and check if a key with string exists
        if let url = Bundle.main.url(forResource: source.rawValue, withExtension: "strings"),
           let data = try? Data(contentsOf: url),
           let plist = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [String:String] {
            if let value = plist[self], !value.isEmpty {
                return value
            }
        }
        
        return self
    }
}
