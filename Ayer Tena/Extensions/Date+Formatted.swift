//
//  Date+Shift.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/22/22.
//

import Foundation

extension Date {
    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}
