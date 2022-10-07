//
//  SettingsView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 10/6/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsVM = SettingsViewModel()
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    AboutView()
                } label: {
                    Label("About Amharic Weather", systemImage: "info.circle")
                }
                
                ShareLink(
                    item: URL(string: "https://www.apple.com/app-store/")!,
                    subject: Text("Amharic Weather App"),
                    message: Text("This is the app I use to get my daily weather info IN AMHARIC.")) {
                    Label("Share with friends", systemImage: "square.and.arrow.up")
                }
                
                if let url = settingsVM.twitterURL {
                    Link(destination: url) {
                        Label("@AmharicWeather", image: "twitter")
                    }
                }
            }
            
            Section {
                if let url =  settingsVM.reviewURL {
                    Link(destination: url) {
                        Label("Review Amharic Weather", systemImage: "star")
                    }
                }
                
                Button {
                    if settingsVM.canSendMail() {
                        settingsVM.isShowingMailView = true
                    }
                } label: {
                    Label("Send us feedback", systemImage: "text.bubble")
                }
                .buttonStyle(.plain)
            }
        }
        .foregroundColor(.primary)
        .navigationTitle("Settings")
        .environment(\.defaultMinListRowHeight, 55)
        .sheet(isPresented: $settingsVM.isShowingMailView) {
            MailView(
                isShowing: $settingsVM.isShowingMailView,
                result: $settingsVM.mailComposeResult,
                to: ["amharicweather@gmail.com"],
                subject: "Feedback"
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SettingsView()
                    .previewDisplayName("Light")
            }
            
            
            NavigationStack {
                SettingsView()
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
