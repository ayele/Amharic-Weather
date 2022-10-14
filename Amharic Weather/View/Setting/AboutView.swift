//
//  AboutView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 10/6/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(spacing: 15) {
                Image("Lightning")
                    .resizable()
                    .scaledToFit()
                
                Text("Amharic Weather is a weather app in አማርኛ. It was created by an independant software developer. Currently the app is only avialble in the US and on iOS only (Android maybe in the future). I came up with the idea when I was looking for a project to improve my programming skills. \n\nThe app gets its data from Apple Weather Service so the accuracy is identical to the native Apple Weather app")
                    .font(.callout)
            }
            
            Button {
                
            } label: {
                HStack {
                    Text("Buy me a coffee")
                    Image(systemName: "cup.and.saucer.fill")
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                }
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .padding()
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            NavigationStack {
                AboutView()
                    .previewDisplayName("Light")
            }
            
            NavigationStack {
                AboutView()
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
