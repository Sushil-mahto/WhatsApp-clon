//
//  Date+Helpers.swift
//  SkWhatsApp
//
//  Created by SUshil on 17/02/22.
//

import Foundation
extension Date{
    func descriptiveString(dateStyle:DateFormatter.Style = .short)->String{
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        let dayBetween = self.dayBetween(date:Date())
        if dayBetween == 0 {
            return "Today"
        }else if dayBetween == 1{
            return "Yesterday"
        }else if dayBetween < 5{
            let weekdayIndex = Calendar.current.component(.weekday, from: self)-1
            return formatter.weekdaySymbols[weekdayIndex]
        }
        
        return formatter.string(from: self)
    }
    func dayBetween(date:Date)->Int{
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        if let dayBetween = calendar.dateComponents([.day], from: date1,to:date2).day{
            return dayBetween
        }
          return 0
    }
}
