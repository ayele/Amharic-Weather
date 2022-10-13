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
    let precipitation: Double?
    let sunrise: Date?
    let sunset: Date?
    
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
        Grid(horizontalSpacing: 15, verticalSpacing: 15) {
            GridRow {
                CardView {
                    Label("UV Index", systemImage: "sun.max.fill")
                } content: {
                    UVIndexView(uvIndex: currentWeather.uvIndex)
                        .frame(height: 120)
                }

                if let sunset, let sunrise {
                    CardView {
                        Label("Sunset", systemImage: "sunset.fill")
                    } content: {
                        SunView(sunrise: sunrise, sunset: sunset)
                            .frame(height: 120)
                    }
                }
            }
            
            GridRow {
                CardView {
                    Label("Wind", systemImage: "wind")
                } content: {
                    WindView(wind: currentWeather.wind)
                        .frame(height: 120)
                }
                
                if let precipitation {
                    CardView {
                        Label("Precipitation", systemImage: "drop.fill")
                    } content: {
                        Text("\(precipitation.formatted(.percent))")
                            .font(.largeTitle).fontWeight(.semibold)
                            .frame(height: 120)
                    }
                }
            }
            
            GridRow {
                CardView {
                    Label("Feels Like", systemImage: "thermometer.medium")
                } content: {
                    Text(apparentTemperature)
                        .font(.largeTitle).fontWeight(.semibold)
                        .frame(height: 120)
                }
                
                CardView {
                    Label("Humidity", systemImage: "humidity.fill")
                } content: {
                    Text(humidity)
                        .font(.largeTitle).fontWeight(.semibold)
                        .frame(height: 120)
                }
            }
            
            GridRow {
                CardView {
                    Label("Visibility", systemImage: "eye.fill")
                } content: {
                    Text(visibility)
                        .font(.largeTitle).fontWeight(.semibold)
                        .frame(height: 120)
                }
                
                CardView {
                    Label("Pressure", systemImage: "gauge")
                } content: {
                    Text(pressure)
                        .font(.largeTitle).fontWeight(.semibold)
                        .frame(height: 120)
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GridView(
                currentWeather: Weather.preview.currentWeather,
                precipitation: 0.34,
                sunrise: Date(),
                sunset: Date()
            )
                .previewDisplayName("Light")
            
            GridView(
                currentWeather: Weather.preview.currentWeather,
                precipitation: 0.34,
                sunrise: Date(),
                sunset: Date()
            )
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
