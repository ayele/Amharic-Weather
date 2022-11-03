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
                        .opacity(tick % 30 == 0 ? 1 : 0.4)
                        .frame(width: 1, height: 8)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick) / 120 * 360))
            }
            Color.clear
            
            Arrow()
                .foregroundStyle(.white)
                .overlay(alignment: .bottom) {
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 8)
                        .foregroundStyle(.white)

                }
                .rotationEffect(Angle(degrees: wind.direction.value - 180))
        }
        .overlay(alignment: .top) {
            Text("ሰ")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .overlay(alignment: .bottom) {
            Text("ደ")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
        }
        .overlay(alignment: .leading) {
            Text("ምስ")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.leading, 30)
        }
        .overlay(alignment: .trailing) {
            Text("ምዕ")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.trailing, 30)
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
                .frame(width: width / 2.5, height: height / 2.5)
                .background(.ultraThinMaterial, in: Circle())
                .offset(x: width / 2.5 - width / 10, y: height / 2.5 - height / 10)
            }
        }
    }
}

struct WindView_Previews: PreviewProvider {
    static var previews: some View {
        WindView(wind: Weather.preview.currentWeather.wind)
            .previewLayout(.fixed(width: 120, height: 120))
    }
}

struct Arrow : Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let width = rect.width
        let height = rect.height
        let radius = height - height * 0.97
        
        p.addLines( [
            CGPoint(x: width * 0.492, y: height - radius * 2),
            CGPoint(x: width * 0.492, y: height * 0.11),
            CGPoint(x: width * 0.45, y: height * 0.13),
            CGPoint(x: width * 0.5, y: height * 0),
            CGPoint(x: width * 0.55, y: height * 0.13),
            CGPoint(x: width * 0.508, y: height * 0.11),
            CGPoint(x: width * 0.508, y: height - radius * 2)
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
