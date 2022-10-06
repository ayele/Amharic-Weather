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
                    Label("About Amharic Weather", systemImage: "cloud")
                }
                
                Label("Share with friends", systemImage: "square.and.arrow.up")
                Label("@AmharicWeather", systemImage: "bird")
            }
            
            Section {
                Label("Review Amharic Weather", systemImage: "star")
                
                Button {
                    if settingsVM.canSendMail() {
                        settingsVM.isShowingMailView = true
                    }
                } label: {
                    Label("Send us feedback", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("Settings")
        .environment(\.defaultMinListRowHeight, 60)
        .sheet(isPresented: $settingsVM.isShowingMailView) {
            MailView(isShowing: $settingsVM.isShowingMailView, result: $settingsVM.mailComposeResult)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SettingsView()
                    .previewDisplayName("Light")
                    .navigationBarTitleDisplayMode(.inline)
            }
            
            
            NavigationStack {
                SettingsView()
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
