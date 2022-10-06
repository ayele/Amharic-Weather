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

    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
