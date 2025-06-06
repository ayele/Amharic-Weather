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
                    .foregroundStyle(Color.blue.gradient)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .minute, count: 10)) { date in
                    let now = forecast.forecast.first?.date
                    let thisDate = date.as(Date.self)
                    
                    AxisTick(length: 5)
                    
                    if now == thisDate {
                        AxisValueLabel("Now")
                    } else {
                        if let thisDate, let now {
                            let interval = thisDate.timeIntervalSince(now)
                            AxisValueLabel("\((interval / 60).formatted(.number.precision(.fractionLength(0))))m")
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(values: .stride(by: 0.33)) {
                    AxisGridLine(stroke: StrokeStyle(dash: [3]))
                }
            }
            .frame(height: 50)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
    }
}

struct MinuteView_Previews: PreviewProvider {
    static var previews: some View {
        MinuteView(forecast: Weather.preview.minuteForecast!)
            .previewDisplayName("Light")
            .previewLayout(.sizeThatFits)
        MinuteView(forecast: Weather.preview.minuteForecast!)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
            .previewLayout(.sizeThatFits)
    }
}
