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
        ZStack {
            ForEach(0..<120) { tick in
                VStack {
                    Rectangle()
                        .fill(.primary)
                        .opacity(tick % 10 == 0 ? 1 : 0.4)
                        .frame(width: 1, height: 8)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick) / 120 * 360))
            }
            Color.clear
            
            Arrow()
                .foregroundStyle(.white)
                .rotationEffect(Angle(degrees: wind.direction.value))
        }
        .overlay(alignment: .center) {
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height

                VStack(spacing: -3) {
                    Text(speed)
                        .fontWeight(.bold)
                    Text("mph")
                        .font(.caption)
                }
                .foregroundColor(.white)
                .frame(width: width / 2, height: height / 2)
                .background(
                    Circle()
                        .foregroundStyle(.blue)
                )
                .offset(x: width / 2 - width / 4, y: height / 2 - height / 4)
            }
        }
        .overlay(alignment: .top) {
            Text("N")
                .padding(.top, 8)
        }
        .overlay(alignment: .bottom) {
            Text("S")
                .padding(.bottom, 8)
        }
        .overlay(alignment: .leading) {
            GeometryReader { geometry in
                Text("E")
                    .offset(x: 8, y: geometry.size.height / 2)
            }
        }
        .overlay(alignment: .trailing) {
            Text("W")
                .padding(.trailing, 11)
        }
    }
}

struct WindView_Previews: PreviewProvider {
    static var previews: some View {
        WindView(wind: Weather.preview.currentWeather.wind)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}

struct Arrow : Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let width = rect.width
        let height = rect.height
        
        p.addLines( [
            CGPoint(x: width * 0.492, y: height),
            CGPoint(x: width * 0.492, y: height * 0.11),
            CGPoint(x: width * 0.45, y: height * 0.13),
            CGPoint(x: width * 0.5, y: height * 0),
            CGPoint(x: width * 0.55, y: height * 0.13),
            CGPoint(x: width * 0.508, y: height * 0.11),
            CGPoint(x: width * 0.508, y: height)
        ])
        
        p.closeSubpath()
        
        return p
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
