//
//  UVBar.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/11/22.
//

import SwiftUI

struct UVBar: View {
    let value: Int
    
    var body: some View {
        Capsule()
            .fill(LinearGradient(colors: [.green, .yellow, .orange, .red, Color("Violet")], startPoint: .leading, endPoint: .trailing))
            .frame(height: Constants.height)
            .overlay {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    
                    Circle()
                        .strokeBorder(.black)
                        .background(Circle().fill(.white))
                        // Reset
                        .offset(x: -(width - Constants.height) / 2)
                        .offset(x: CGFloat(value) * (width - Constants.height) / Constants.indices)
                }
            }
    }
    
    private struct Constants {
        static let height: CGFloat = 5
        static let indices: CGFloat = 12
    }
}

struct UVBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UVBar(value: 3)
                .previewDisplayName("Light")
            UVBar(value: 3)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
