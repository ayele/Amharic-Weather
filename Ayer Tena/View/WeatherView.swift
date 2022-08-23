//
//  WeatherView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import SwiftUI

struct WeatherView: View {
    var weather: Weather
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack(spacing: -5) {
                    Text("Middleton").font(.largeTitle)
                    Text("\(weather.current.temperature.roundDouble())")
                        .font(.system(size: 90))
                    VStack(spacing: 5) {
                        Text("\(weather.current.condition[0].description)").font(.title3)
                        HStack {
                            Text("H:80°").font(.title3)
                            Text("L:58°").font(.title3)
                        }
                    }
                }
                .padding(50)
                
                // Hourly
                VStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(weather.hourly) { hourly in
                                VStack(spacing: 15) {
                                    Text("\(hourly.time.formattedHour())")
                                    Image(systemName: "\(hourly.condition[0].icon.imageName)")
                                    Text("\(hourly.temperature.roundDouble())°")
                                }
                            }
                        }
                    }
                    .padding()
                    .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
                    
                    // Daily
                    VStack(spacing: 15) {
                        ForEach(weather.daily) { daily in
                            VStack {
                                HStack {
                                    Text("\(daily.time.formattedDay())")
                                        .frame(width: 100, alignment: .leading)
                                    Spacer()
                                    Image(systemName: "\(daily.condition[0].icon.imageName)")
                                    Spacer()
                                    Text("\(daily.temperature.low.roundDouble())° - \(daily.temperature.high.roundDouble())°")
                                        .frame(width: 100, alignment: .trailing)
                                }
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
                }
            }
            .padding()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: Weather.sampleData)
    }
}
