//
//  String+Fill.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/10/22.
//

import Foundation
import SwiftUI

extension String {
    // Returns whether an FS Symbol has a fill version
    func hasFill() -> Bool {
        let image = UIImage(systemName: "\(self).fill")
        return image != nil
    }
}
