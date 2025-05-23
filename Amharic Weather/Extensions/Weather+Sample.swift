//
//  Weather+Sample.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/29/22.
//

import Foundation
import WeatherKit

extension Weather {
    static var preview: Weather {
        print("loading preview data...")
       
        let data: Data

        guard let file = Bundle.main.url(forResource: "weather", withExtension: "json")
        else {
            fatalError("Couldn't find weather.json in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load weather.json from main bundle:\n\(error)")
        }
        
        do {
            return try JSONDecoder().decode(Weather.self, from: data)
        } catch {
            fatalError("Couldn't parse weather.json as \(Weather.self):\n\(error)")
        }
    }
}
