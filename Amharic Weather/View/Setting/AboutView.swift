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
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .font(.callout)
            }
            /*
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
             */
            
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
