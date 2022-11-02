//
//  SunView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/12/22.
//

import SwiftUI

struct SunView: View {
    let currentTime: Date
    let sunrise: Date
    let sunset: Date
    
    var sunAngle: Angle? {
        if isToday(sunrise) && isToday(sunset) {
            let diffComponents = Calendar.current.dateComponents([.minute], from: sunrise, to: sunset)
            let totalMinutes = diffComponents.minute
            let currentComponents = Calendar.current.dateComponents([.minute], from: sunrise, to: currentTime)
            let currentMinutes = currentComponents.minute
            
            if let totalMinutes, let currentMinutes {
                let angle = Angle(degrees: Double(currentMinutes) / Double(totalMinutes) * 180)
                return angle
            }
        }
        return nil
    }
    
    var body: some View {
        VStack {
            Arc()
                .stroke(lineWidth: 5)
                .foregroundColor(.secondary)
                .frame(width: 100, height: 100)
                .overlay {
                    Dot(angle: sunAngle ?? Angle(degrees: 0))
                        .foregroundColor(.yellow)
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(spacing: 3) {
                        Image(systemName: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(sunrise.formatted(date: .omitted, time: .shortened))
                            .font(.caption)
                    }
                    .offset(x: -24, y: -7)
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack(spacing: 3) {
                        Image(systemName: "sunset.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(sunset.formatted(date: .omitted, time: .shortened))
                            .font(.caption)
                    }
                    .offset(x: 24, y: -7)
                }
        }
    }
    
    private func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}

struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SunView(currentTime: Date(), sunrise: Date(), sunset: Date())
                .previewDisplayName("Light")
            SunView(currentTime: Date(), sunrise: Date(), sunset: Date())
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}

struct Arc : Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        var p = Path()
        
        p.addArc(center: center,
                 radius: radius,
                 startAngle: .degrees(0),
                 endAngle: .degrees(180),
                 clockwise: true)

        return p
    }
}

struct Dot : Shape {
    let angle: Angle
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let modifiedAngle = -angle - Angle(degrees: 90)
        let position = CGPoint(
            x: center.x + radius * CGFloat(sin(modifiedAngle.radians)),
            y: center.y + radius * CGFloat(cos(modifiedAngle.radians))
        )
        
        var p = Path()
        
        p.addArc(center: position,
                 radius: 5,
                 startAngle: .degrees(0),
                 endAngle: .degrees(360),
                 clockwise: true)

        return p
    }
}
