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
            
            VStack {
                Arrow()
                    .fill(.orange)
                    .frame(width: 10, height: 24)
                    .offset(y: -8)
                Spacer()
            }
            .rotationEffect(Angle(degrees: wind.direction.value))

            Color.clear
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
            VStack(spacing: -3) {
                Text(speed)
                    .fontWeight(.bold)
                Text("mph")
                    .font(.caption)
            }
            .foregroundStyle(.white)
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
        
        p.addLines( [
            CGPoint(x: width * 0.5, y: height),
            CGPoint(x: 0, y: 0),
            CGPoint(x: width, y: 0),
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
