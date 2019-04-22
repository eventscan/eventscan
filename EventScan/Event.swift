//
//  Event.swift
//  EventScan
//
//  Created by Abid Amirali on 4/15/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import Foundation

struct Event {
    let name: String
    let location: String
//    let date: String
    let day: String
    let time: String
    let year: String
    let month: String
    let detail: String
    
    var date: Date {
        
        let year = self.year.count > 0 ? (self.year.count > 2 ? "yyyy" : "yy") : "yyyy"
        let day = self.day.count > 0 ? (self.day.count <= 2 ? "dd" : (self.day.count <= 4 ? "E" : "EEEE")) : "EEEE"
        let month = self.month.count > 0 ? (self.day.count <= 2 ? "MM" : (self.day.count == 3 ? "MMM" : "MMMM")) : "MM"
        
        //todo time
        var time = "HH:MM"
        if self.time.contains(":") {
            let timeComponents = self.time.split(separator: ":")
            if timeComponents.count == 2 {
                time = "HH:MM"
            }
        } else {
            time = "HH"
        }
    
        if self.time.contains("AM") || self.time.contains("PM") {
            time += "-a"
        }
        
        
        var formatString = ""
        formatString += (day.count > 0) ? day + "-" : ""
        formatString += (month.count > 0) ? month + "-" : ""
        formatString += (year.count >  0) ? year + "-": ""
        formatString += (time.count > 0) ? time + "-" : ""
        
        var valueString = ""
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd"
        valueString += (day.count > 0) ? self.day + "-" : dateFormatter.string(from: currentDate)
        dateFormatter.dateFormat = "MM"
        valueString += (month.count > 0) ? self.month + "-" : dateFormatter.string(from: currentDate)
        dateFormatter.dateFormat = "yyyy"
        valueString += (year.count >  0) ? self.year + "-": dateFormatter.string(from: currentDate)
//        valueString += (time.count > 0) ? self.time + "-" : ""
        
        if time.count > 0 {
            if self.time.contains("AM") {
                let timeString = String(self.time[self.time.startIndex..<self.time.index(of: "A")!])
                valueString += timeString
                valueString += "-AM"
            } else if self.time.contains("PM") {
                let timeString = String(self.time[self.time.startIndex..<self.time.index(of: "P")!])
                valueString += timeString
                valueString += "-PM"
            } else {
                valueString += self.time
            }
        } else {
            dateFormatter.dateFormat = "HH::MM"
            valueString += "-" + dateFormatter.string(from: currentDate)
        }
        
        dateFormatter.dateFormat = formatString //Your date format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        //according to date format your date string
        print(formatString, valueString)
        guard let date = dateFormatter.date(from: valueString) else {
            return currentDate
        }
        return date
    }
    
}
