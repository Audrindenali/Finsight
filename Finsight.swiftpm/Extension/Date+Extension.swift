//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 14/04/23.
//

import Foundation

extension Date {
    func startOfDay() -> Date? {
            return Calendar.current.startOfDay(for: self)
        }

        func endOfDay() -> Date? {
            let startDay = Calendar.current.startOfDay(for: self)
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startDay)
        }
    
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    func startOfMonth() -> Date? {
            return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
        }
        
        func endOfMonth() -> Date? {
            return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()!)
        }
    
    func endOfYear() -> Date? {
        let year = Calendar.current.component(.year, from: Date())
        // Get the first day of next year
        guard let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) else { return nil }
        
        return Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)
    }
    
    func startOfYear() -> Date? {
        let year = Calendar.current.component(.year, from: Date())
        // Get the first day of next year
        guard let endOfPrevYear = Calendar.current.date(from: DateComponents(year: year - 1 , month: 12, day: 31)) else { return nil }
        
        return Calendar.current.date(byAdding: .day, value: +1, to: endOfPrevYear)
    }
    
}

