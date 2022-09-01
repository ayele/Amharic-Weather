//
//  MinuteView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/30/22.
//

import SwiftUI
import WeatherKit
import Charts

struct MinuteView: View {
    let forecast: Forecast<MinuteWeather>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Rain Forecasted")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 1)
            
            Text("Rain for the next hour")
                .font(.subheadline)
            
            Chart {
                ForEach(forecast.forecast, id: \.date) { minute in
                    BarMark(
                        x: .value("Time", minute.date, unit: .minute),
                        y: .value("Prec", minute.precipitationChance),
                        width: 4
                    )
                }
            }
            .chartYAxis(.hidden)
            .frame(height: 70)
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

struct MinuteView_Previews: PreviewProvider {
    static var previews: some View {
        MinuteView(forecast: Weather.sample.minuteForecast!)
            .previewDisplayName("Light")
            .previewLayout(.sizeThatFits)
        MinuteView(forecast: Weather.sample.minuteForecast!)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
            .previewLayout(.sizeThatFits)
    }
}
