//
//  SWConcreteDateStringifier.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteDateStringifier: SWDateStringifier {
    
    func stringify(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func stringify(_ date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
//            return "Today, \(hour):\(minute):\(second)"
            return "Today, \(self.stringify(date, format: "HH:mm:ss"))"
        }
        else if Calendar.current.isDateInYesterday(date) {
//            return "Yesterday, \(hour):\(minute):\(second)"
            return "Yesterday, \(self.stringify(date, format: "HH:mm:ss"))"
        }
        else if date > Calendar.current.date(byAdding: .day, value: -7, to: Date())! {
//            let dayName = Calendar.current.weekdaySymbols[weekDay]
//            return "\(dayName), \(hour):\(minute):\(second)"
            return self.stringify(date, format: "EEEE, HH:mm:ss")
        }
        else if date > Calendar.current.date(byAdding: .year, value: -1, to: Date())! {
//            return "\(day) of \(monthName), \(hour):\(minute):\(second)"
            return "\(self.stringify(date, format: "d")) of \(self.stringify(date, format: "MMMM, HH:mm:ss"))"
        }
        else {
//            return "\(day) of \(monthName) \(year), \(hour):\(minute):\(second)"
            return "\(self.stringify(date, format: "d")) of \(self.stringify(date, format: "MMMM y, HH:mm:ss"))"
        }
    }
    
}
