//
//  ScheduleListView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 27.04.22.
//

import SwiftUI
import CampusDualKit

struct ScheduleListView: View {
    
    @Binding public var studyDays: [StudyDay]
    @State public var lastOnlineUpdate: Date
    @EnvironmentObject var settings: Settings
    
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
            if !self.studyDays.isEmpty {
                Section(content: {}, footer: {
                    Text("SCHEDULE.LAST.UPDATE \(self.lastOnlineUpdate.formatted())")
                })
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(studyDays: .constant(StudyDay.demoData), lastOnlineUpdate: Date())
            .environment(\.locale, .init(identifier: "de"))
            .environmentObject(Settings())
    }
}
