//
//  SettingsViewModel.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 10/6/22.
//

import Foundation
import MessageUI

class SettingsViewModel: ObservableObject {
    @Published var isShowingMailView = false
    @Published var mailComposeResult: Result<MFMailComposeResult, Error>? = nil
    
    var twitterURL: URL? {
        let twitterURLStringApp = "twitter://user?screen_name=AmharicWeather"
        let twitterURLStringWeb = "https://twitter.com/AmharicWeather"
        
        let appURL = URL(string: twitterURLStringApp)
        let webURL = URL(string: twitterURLStringWeb)
        
        if let appURL {
            if UIApplication.shared.canOpenURL(appURL) {
                return appURL
            } else {
                return webURL
            }
        }

        return nil
    }
    
    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
