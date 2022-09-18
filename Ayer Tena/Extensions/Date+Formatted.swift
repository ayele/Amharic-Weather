//
//  Date+Shift.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/22/22.
//

import Foundation

extension Date {
    func hourOfDay() -> String {
        if Calendar.current.isDate(Date.now, equalTo: self, toGranularity: .hour) {
            return "Now"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func dayOfWeek() -> String {
        if Calendar.current.isDate(Date.now, equalTo: self, toGranularity: .day) {
            return "Today"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}
