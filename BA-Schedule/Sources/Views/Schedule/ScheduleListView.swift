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
    
    var body: some View {
        List {
            ForEach(studyDays, id: \.self) { studyDay in
                Section {
                    ForEach(studyDay.lessons, id: \.self) { lesson in
                        Lesson(lesson: lesson)
                    }
                } header: {
                    Text(studyDay.day.formatted(date: .complete, time: .omitted))
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(studyDays: StudyDay.demoData)
            .environment(\.locale, .init(identifier: "de"))
    }
}
