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
    
    var apparentTemperature: String {
        return "\(currentWeather.apparentTemperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°"
    }
    
    var humidity: String {
        return "\(currentWeather.humidity.formatted(.percent))"
    }
    
    var dewPoint: String {
        return "\(currentWeather.dewPoint.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°"
    }
    
    var visibility: String {
        return "\(currentWeather.visibility.formatted())"
    }
       
    var body: some View {
        Grid(horizontalSpacing: 15, verticalSpacing: 15) {
            GridRow {
                CardView {
                    Label("የዩቪ መረጃ ጠቋሚ", systemImage: "sun.max.fill")
                } content: {
                    UVIndexView(uvIndex: currentWeather.uvIndex)
                        .frame(height: 120)
                }

                if let sunset, let sunrise {
                    CardView {
                        Label("ፀሐይ", systemImage: "sun.and.horizon.fill")
                    } content: {
                        SunView(currentTime: currentWeather.date,
                                sunrise: sunrise,
                                sunset: sunset)
                            .frame(height: 120)
                    }
                }
            }
            
            GridRow {
                CardView {
                    Label("ነፋስ", systemImage: "wind")
                } content: {
                    WindView(wind: currentWeather.wind)
                        .frame(height: 120)
                }
                
                if let precipitation {
                    CardView {
                        Label("ዝናብ", systemImage: "drop.fill")
                    } content: {
                        VStack(alignment: .leading) {
                            Text((round(precipitation * 10) / 10.0).formatted(.percent))
                                .font(.largeTitle).fontWeight(.semibold)
                            Spacer()
                            Text("የዛሬ የዝናብ ዕድል \((round(precipitation * 10) / 10.0).formatted(.percent)) ነዉ")
                                .font(.caption)
                        }
                        .frame(height: 120)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            GridRow {
                CardView {
                    Label("የሚሰማው ሙቀት", systemImage: "thermometer.medium")
                } content: {
                    VStack(alignment: .leading) {
                        Text(apparentTemperature)
                            .font(.largeTitle).fontWeight(.semibold)
                        Spacer()
                        if currentWeather.apparentTemperature > currentWeather.temperature {
                            Text("በ እርጥበት ምክንያት አየሩ ሞቅ ብሎ ይሰማል")
                                .font(.caption)
                        } else if currentWeather.apparentTemperature < currentWeather.temperature {
                            Text("በ ነፋስ ምክንያት አየሩ ቀዝቀዝ ብሎ ይሰማል")
                                .font(.caption)
                        } else {
                            Text("የሚሰማዉ ሙቀትና የተለካዉ ሙቀት አንድ ናቸው")
                                .font(.caption)
                        }
                    }
                    .frame(height: 120)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                CardView {
                    Label("እርጥበት", systemImage: "humidity.fill")
                } content: {
                    VStack(alignment: .leading) {
                        Text(humidity)
                            .font(.largeTitle).fontWeight(.semibold)
                        Spacer()
                        Text("በአሁኑ ሰዓት የጤዛ ነጥብ \(dewPoint) ነዉ")
                            .font(.caption)
                    }
                    .frame(height: 120)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            GridRow {
                CardView {
                    Label("ታይነት", systemImage: "eye.fill")
                } content: {
                    VStack(alignment: .leading) {
                        Text(visibility)
                            .font(.largeTitle).fontWeight(.semibold)
                        Spacer()
                        if currentWeather.visibility > Measurement(value: 8, unit: .miles) {
                            Text("በአሁኑ ሰዓት አየሩ እጅግ በጣም ግልጽ ነዉ")
                                .font(.caption)
                        } else {
                            Text("በአሁኑ ሰዓት አየሩ በጣም ግልጽ አይደለም")
                                .font(.caption)
                        }
                    }
                    .frame(height: 120)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                CardView {
                    Label("ግፊት", systemImage: "gauge")
                } content: {
                    PressureView(pressure: currentWeather.pressure)
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
