//
//  SWConcreteDateStringifier.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteDateStringifier: SWDateStringifier {
    
    func stringify(_ date: Date) -> String {
        let second = Calendar.current.component(.second, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        let hour = Calendar.current.component(.hour, from: date)
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let weekDay = Calendar.current.component(.weekdayOrdinal, from: date)
        let monthName = Calendar.current.monthSymbols[month]
        
        if Calendar.current.isDateInToday(date) {
            return "Today, \(hour):\(minute):\(second)"
        }
        else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday, \(hour):\(minute):\(second)"
        }
        else if date > Calendar.current.date(byAdding: .day, value: -7, to: date)! {
            let dayName = Calendar.current.weekdaySymbols[weekDay]
            return "\(dayName), \(hour):\(minute):\(second)"
        }
        else if date > Calendar.current.date(byAdding: .year, value: -1, to: date)! {
            return "\(day) of \(monthName), \(hour):\(minute):\(second)"
        }
        else {
            return "\(day) of \(monthName) \(year), \(hour):\(minute):\(second)"
        }
    }
    
}