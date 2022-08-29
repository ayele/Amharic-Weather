//
//  Localization.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/28/22.
//

import Foundation

struct Localization {
    static func localize(_ string: String, comment: String) -> String {
        // retrieve the cache and check if a key with string exists
        if let url = Bundle.main.url(forResource: "Localizable", withExtension: "strings"),
           let data = try? Data(contentsOf: url),
           let plist = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [String:String] {
            if let value = plist[string], !value.isEmpty {
                return value
            }
        }
        
        return NSLocalizedString(string, comment: comment)
    }
}
