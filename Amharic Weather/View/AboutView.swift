//
//  AboutView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 10/6/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .padding()
            
            Text("Amharic Weather is a weather app in አማርኛ. It was created by an independant software developer. Currently the app is only avialble in the US and on iOS only (Android maybe in the future). I came up with the idea when I was looking for a project to improve my programming skills. \n\nThe app gets its data from Apple Weather Service so the accuracy is identical to the native Apple Weather app")
            
            Spacer()
        }
        .padding()
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AboutView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
