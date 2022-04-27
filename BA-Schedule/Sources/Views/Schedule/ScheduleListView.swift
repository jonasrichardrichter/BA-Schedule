//
//  ScheduleListView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 27.04.22.
//

import SwiftUI
import CampusDualKit

struct ScheduleListView: View {
    
    @State public var studyDays: [StudyDay]
    @State public var lastOnlineUpdate: Date
    
    var body: some View {
        List {
            ForEach(studyDays, id: \.self) { studyDay in
                Section(content: {
                    ForEach(studyDay.lessons, id: \.self) { lesson in
                        Lesson(lesson: lesson)
                    }
                }, header: {
                    Text(studyDay.day.formatted(date: .complete, time: .omitted))
                })
            }
            Section(content: {}, footer: {
                Text("SCHEDULE.LAST.UPDATE \(self.lastOnlineUpdate.formatted())")
            })
        }
        .listStyle(.insetGrouped)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(studyDays: StudyDay.demoData, lastOnlineUpdate: Date())
            .environment(\.locale, .init(identifier: "de"))
    }
}
