//
//  ScheduleView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI
import CampusDualKit

struct ScheduleView: View {
    var body: some View {
        NavigationView {
            List {
                Lesson(lesson: CampusDualKit.Lesson.example)
            }
            .listStyle(.plain)
        .navigationTitle("SCHEDULE")
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
