//
//  GridView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/8/22.
//

import SwiftUI
import WeatherKit

struct GridView: View {
    let currentWeather: CurrentWeather
    
    var uvIndex: String {
        return "\(currentWeather.uvIndex.value)"
    }
    
    var wind: String {
        return "\(currentWeather.wind.speed.converted(to: .milesPerHour).value.formatted(.number.precision(.fractionLength(0)))) mph"
    }
    
    var apparentTemperature: String {
        return "\(currentWeather.apparentTemperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°"
    }
    
    var humidity: String {
        return "\(currentWeather.humidity.formatted(.percent))"
    }
    
    var visibility: String {
        return "\(currentWeather.visibility.formatted())"
    }
    
    var pressure: String {
        return "\(currentWeather.pressure.converted(to: .inchesOfMercury).value.formatted(.number.precision(.fractionLength(0)))) inHg"
    }
       
    var body: some View {
        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
            GridRow {
                SquareView(category: "UV Index", value: uvIndex)
                SquareView(category: "Sunrise", value: "5:45 AM")
            }
            
            GridRow {
                SquareView(category: "Wind", value: wind)
                SquareView(category: "Precipitation", value: "0\"")
            }
            
            GridRow {
                SquareView(category: "Feels Like", value: apparentTemperature)
                SquareView(category: "Humidity", value: humidity)
            }
            
            GridRow {
                SquareView(category: "Visibility", value: visibility)
                SquareView(category: "Pressure", value: pressure)
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GridView(currentWeather: Weather.preview.currentWeather)
                .previewDisplayName("Light")
            GridView(currentWeather: Weather.preview.currentWeather)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
