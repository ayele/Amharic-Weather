//
//  CardView.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/10/22.
//

import SwiftUI

struct CardView<Title: View, Content: View>: View {
    var title: Title
    var content: Content
    
    init(@ViewBuilder title: @escaping () -> Title, @ViewBuilder content: @escaping () -> Content){
        self.title = title()
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            title
                .foregroundColor(.secondary)
                .font(.system(size: 13))
                .lineLimit(1)
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial, in: RoundedCorner(radius: 15, corners: [.topLeft,.topRight]))
            
            VStack(spacing: 0) {
                Divider()
                content
                    .padding()
            }
            .background(.ultraThinMaterial, in: RoundedCorner(radius: 15, corners: [.bottomLeft, .bottomRight]))
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
