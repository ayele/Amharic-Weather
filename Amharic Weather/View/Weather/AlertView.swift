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
            summaries.insert(alert.summary.localize(.weather))
        }
        
        return summaries.joined(separator: "፣ ")
    }
    
    var sources: String {
        // Concatenate all unique sources into a string
        var sources = Set<String>()
        for alert in alerts {
            sources.insert(alert.source.localize(.weather))
        }
        
        return sources.joined(separator: "፣ ")
    }
    
    var regions: String {
        // Concatenate all unique regions into a string
        var regions = Set<String>()
        for alert in alerts {
            if let region = alert.region {
                regions.insert(region.localize(.city))
            }
        }
        
        return regions.joined(separator: "፣ ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("ከባድ የአየር ሁኔታ")
                Spacer()
            }
            .font(.title3)
            .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(summaries). (\(sources))")
                    .font(.subheadline)
                Text("\(sources) • \(regions)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alerts: [Weather.preview.weatherAlerts![1]])
            .previewDisplayName("Light")
            .previewLayout(.sizeThatFits)
        AlertView(alerts: [Weather.preview.weatherAlerts![1]])
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
            .previewLayout(.sizeThatFits)
    }
}
