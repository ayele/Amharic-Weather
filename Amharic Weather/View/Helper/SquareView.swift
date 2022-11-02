//
//  SquareView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/8/22.
//

import SwiftUI

struct SquareView: View {
    let category: String
    let value: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(value)
                    .font(.title)
                Text(category)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .frame(height: 185)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(category: "Precipitation", value: "9%")
    }
}
