//
//  StudyDay+AppReviewDemoData.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 01.02.22.
//

import Foundation
import CampusDualKit

internal extension StudyDay {
    static var demoData: [StudyDay] {
        var array: [StudyDay] = []
        
        for item in 0..<20 {
            var dateComponent = DateComponents()
            dateComponent.day = item
            
            let demoDate = Calendar.current.date(byAdding: dateComponent, to: Date()) ?? Date()
            
            let studyDay = StudyDay(day: demoDate, lessons: [
                CampusDualKit.Lesson(title: "Mathe", start: Calendar.current.date(bySettingHour: 7, minute: 45, second: 0, of: demoDate) ?? Date(), end: Calendar.current.date(bySettingHour: 9, minute: 15, second: 0, of: demoDate) ?? Date(), description: "Mathe Modul", room: "R201", instructor: "Prof. Dr. Mustermann", remarks: "Gruppe A"),
                CampusDualKit.Lesson(title: "Informatik", start: Calendar.current.date(bySettingHour: 9, minute: 45, second: 0, of: demoDate) ?? Date(), end: Calendar.current.date(bySettingHour: 11, minute: 15, second: 0, of: demoDate) ?? Date(), description: "Informatik Modul", room: "R203", instructor: "Frau Programmiererin", remarks: "Gruppe B"),
                CampusDualKit.Lesson(title: "Englisch", start: Calendar.current.date(bySettingHour: 11, minute: 45, second: 0, of: demoDate) ?? Date(), end: Calendar.current.date(bySettingHour: 13, minute: 15, second: 0, of: demoDate) ?? Date(), description: "Englisch Modul", room: "R104", instructor: "EVL", remarks: "Gruppe C")
            ])
            array.append(studyDay)
        }
        return array
    }
}
