//
//  Date+Shift.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/22/22.
//

import Foundation

extension Date {
    func hourOfDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US")
        let day = dateFormatter.string(from: self)
        
        switch day {
        case "Monday":
            return "ሰኞ"
        case "Tuesday":
            return "ማክሰኞ"
        case "Wednesday":
            return "ረቡዕ"
        case "Thursday":
            return "ኀሙስ"
        case "Friday":
            return "ዐርብ"
        case "Saturday":
            return "ቅዳሜ"
        case "Sunday":
            return "እሁድ"
        default:
            return "ዛሬ"
        }
    }
}
