//
//  CurrentView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/27/22.
//

import SwiftUI
import WeatherKit

struct CurrentView: View {
    let currentWeather: CurrentWeather
    let city: String
    
    var body: some View {
        VStack(spacing: -5) {
            Text(city.localize())
                .font(Font.custom("SofiaProLight", size: 35))
                .padding(.bottom, 10)
            Text("\(currentWeather.temperature.converted(to: .fahrenheit).value.formatted(.number.precision(.fractionLength(0))))°")
                .font(Font.custom("SofiaProLight", size: 90))
                .padding(.leading, 30) // offsets the ° symbol
            Text("\(currentWeather.condition.description.localize())")
                .font(Font.custom("SofiaProLight", size: 20))
        }
        .padding(40)
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView(currentWeather: Weather.sample.currentWeather, city: "Middleton")
            .previewDisplayName("Light")
        CurrentView(currentWeather: Weather.sample.currentWeather, city: "Middleton")
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
