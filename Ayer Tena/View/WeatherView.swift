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
                .padding()
                
                // Hourly
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<8, id: \.self) { index in
                            VStack(spacing: 15) {
                                Text("Now")
                                Image(systemName: "sun.max.fill")
                                Text("77°")
                            }
                        }
                    }
                }
                .padding()
                
                // Daily
                VStack(spacing: 20) {
                    ForEach(0..<8) { index in
                        VStack {
                            HStack {
                                Text("Monday")
                                Spacer()
                                Image(systemName: "cloud")
                                Spacer()
                                Text("55°")
                                Text("-")
                                Text("80°")
                            }
                            Divider()
                        }
                    }
                }
                .padding()
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
