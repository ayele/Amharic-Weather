//
//  PressureView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 11/1/22.
//

import SwiftUI
import WeatherKit

struct PressureView: View {
    let pressure: Measurement<UnitPressure>
    
    var inchesOfMercury: String {
        return pressure.converted(to: .inchesOfMercury).value.formatted(.number.precision(.fractionLength(2)))
    }
    
    var scaledPressure: Int {
        let pressureLow = 28.0
        let pressureHigh = 31.5
        let scaleLow = 0.0
        let scaleHigh = 48.0
        let pressure = pressure.converted(to: .inchesOfMercury).value
        let pressureRange = pressureHigh - pressureLow
        let scaleRange = scaleHigh - scaleLow
        let scaledPressure = (((pressure - pressureLow) * scaleRange) / pressureRange + scaleLow)
        
        return Int(scaledPressure)
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<49) { tick in
                VStack {
                    Rectangle()
                        .fill(tick == scaledPressure ? .white : .primary)
                        .cornerRadius(tick == scaledPressure ? 2 : 0)
                        .frame(width: tick == scaledPressure ? 4 : 1, height: tick == scaledPressure ? 20 : 12)
                        .offset(y: tick == scaledPressure ? -4 : 0)
                        
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick + 40) / 48 * 270))
            }
            Color.clear
        }
        .overlay(alignment: .center) {
            VStack {
                Text(inchesOfMercury)
                    .fontWeight(.bold)
                Text("inHg")
                    .font(.caption)
            }
        }
        .overlay(alignment: .bottom) {
            HStack {
                Text("ዝቅ")
                Spacer()
                Text("ከፍ")
            }
            .font(.caption)
            .padding(.horizontal, 40)
        }
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView(pressure: Weather.preview.currentWeather.pressure)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}

//struct Arrow : Shape {
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//
//        let width = rect.width
//        let height = rect.height
//
//        p.addLines( [
//            CGPoint(x: width * 0.49, y: height),
//            CGPoint(x: width * 0.49, y: height * 0.11),
//            CGPoint(x: width * 0.43, y: height * 0.13),
//            CGPoint(x: width * 0.5, y: height * 0),
//            CGPoint(x: width * 0.57, y: height * 0.13),
//            CGPoint(x: width * 0.51, y: height * 0.11),
//            CGPoint(x: width * 0.51, y: height)
//        ])
//
//        p.closeSubpath()
//
//        return p
//    }
//}
//
//struct Arrow_Previews: PreviewProvider {
//    static var previews: some View {
//        Arrow()
//            .previewLayout(.fixed(width: 300, height: 300))
//    }
//}

