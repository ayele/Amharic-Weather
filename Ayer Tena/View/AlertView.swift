//
//  AlertView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/29/22.
//

import SwiftUI
import WeatherKit

struct AlertView: View {
    let alerts: [WeatherAlert]
    
    var summaries: String {
        // Concatenate all unique summaries into a string
        var summaries = Set<String>()
        for alert in alerts {
            summaries.insert(alert.summary)
        }
        
        return summaries.joined(separator: ", ")
    }
    
    var sources: String {
        // Concatenate all unique sources into a string
        var sources = Set<String>()
        for alert in alerts {
            sources.insert(alert.source)
        }
        
        return sources.joined(separator: ", ")
    }
    
    var regions: String {
        // Concatenate all unique regions into a string
        var regions = Set<String>()
        for alert in alerts {
            if let region = alert.region {
                regions.insert(region)
            }
        }
        
        return regions.joined(separator: ", ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top) {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("Severe Weather")
                Spacer()
            }
            .font(.title3)
            .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(summaries). (\(sources))")
                    .font(.subheadline)
                Text("\(sources) • \(regions)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alerts: [Weather.sample.weatherAlerts![1]])
            .previewDisplayName("Light")
            .previewLayout(.sizeThatFits)
        AlertView(alerts: [Weather.sample.weatherAlerts![1]])
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
            .previewLayout(.sizeThatFits)
    }
}
