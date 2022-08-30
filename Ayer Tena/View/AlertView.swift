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
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image(systemName: "exclamationmark.triangle")
                Text("\(alerts.first?.summary ?? "")\(alerts.count > 1 ? " & \(alerts.count - 1) More" : "")")
            }
            .font(.title3)
            .fontWeight(.medium)
            
            Text("\(alerts.first?.source ?? ""): \(alerts.first?.summary ?? "") in \(alerts.first?.region ?? "").")
                .foregroundColor(.secondary)
            
            Divider()
            Button {
                onTap()
            } label: {
                HStack {
                    Text("See more")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .buttonStyle(.plain)
            .foregroundColor(.secondary)
        }
        .padding()
        .overlay { RoundedRectangle(cornerRadius: 15).stroke(.gray, lineWidth: 1) }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alerts: [Weather.sample.weatherAlerts![1]], onTap: {})
        AlertView(alerts: [Weather.sample.weatherAlerts![1]], onTap: {})
            .preferredColorScheme(.dark)
    }
}
