//
//  WindView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/12/22.
//

import SwiftUI
import WeatherKit

struct WindView: View {
    let wind: Wind
    
    var speed: String {
        return "\(wind.speed.converted(to: .milesPerHour).value.formatted(.number.precision(.fractionLength(0))))"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 7)
            .foregroundColor(.secondary)
            .overlay {
                VStack(spacing: 0) {
                    Text(speed)
                    Text("mph")
                }
                .font(.headline)
            }
    }
}

struct WindView_Previews: PreviewProvider {
    static var previews: some View {
        WindView(wind: Weather.preview.currentWeather.wind)
    }
}
