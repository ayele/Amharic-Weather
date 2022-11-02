//
//  SunView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/12/22.
//

import SwiftUI

struct SunView: View {
    let sunrise: Date
    let sunset: Date
    
    var body: some View {
        VStack {
            Arc()
                .foregroundColor(.secondary)
                .frame(width: 100, height: 100)
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
}

struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SunView(sunrise: Date(), sunset: Date())
                .previewDisplayName("Light")
            SunView(sunrise: Date(), sunset: Date())
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

        return p.strokedPath(.init(lineWidth: 5))
    }
}
