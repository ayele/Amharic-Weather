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
                CurrentView(weather: weather)
                
                VStack(spacing: 20) {
                    HourlyView(weather: weather)
                    DailyView(weather: weather)
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

struct CurrentView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: -5) {
            Text("\(weather.city?.name ?? "--")").font(.largeTitle)
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
    }
}

struct HourlyView: View {
    let weather: Weather
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                // We only need 24 hrs of hourly
                ForEach(weather.hourly) { hourly in
                    VStack(spacing: 15) {
                        Text("\(hourly.time.hourOfDay())")
                        Image(systemName: "\(hourly.condition[0].icon.imageName)")
                            .font(.title3)
                        Text("\(hourly.temperature.roundDouble())°")
                    }
                }
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

struct DailyView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(weather.daily) { daily in
                VStack {
                    HStack {
                        Text("\(daily.time.dayOfWeek())")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        Image(systemName: "\(daily.condition[0].icon.imageName)")
                            .font(.title3)
                        Spacer()
                        HStack {
                            Text("\(daily.temperature.low.roundDouble())°")
                                .foregroundColor(.secondary)
                            Image(systemName: "minus")
                                .foregroundColor(.secondary)
                            Text("\(daily.temperature.high.roundDouble())°")
                        }
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
