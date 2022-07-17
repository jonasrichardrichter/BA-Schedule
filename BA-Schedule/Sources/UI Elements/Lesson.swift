//
//  Lesson.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI
import CampusDualKit

struct Lesson: View {
    
    @EnvironmentObject var settings: Settings
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var lesson: CampusDualKit.Lesson
    
    var body: some View {
        HStack {
            // TODO: Switch color of rounded rectangle based on the module the lessons is part of
            /* RoundedRectangle(cornerRadius: 30)
             .frame(width: 6, height: 40)
             .foregroundColor(.blue) */
            
            VStack(alignment: .leading, spacing: nil) {
                Text(lesson.title)
                    .font(.headline)
                AdaptiveStack(horizontalAlignment: .leading) {
                    if !self.lesson.room.isEmpty {
                        HStack {
                            Image(systemName: "building.2.crop.circle")
                            Text(lesson.room)
                        }
                    }
                    if self.settings.showInstructor {
                        if self.sizeClass == .regular {
                            Text("・")
                        }
                        HStack {
                            Image(systemName: "person.circle")
                            Text(lesson.instructor)
                        }
                    }
                    if (!self.lesson.remarks.isEmpty && self.settings.showRemarks) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text(lesson.remarks)
                        }
                    }
                }.foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(lesson.start.formatted(.dateTime.hour().minute()))
                Text(lesson.end.formatted(.dateTime.hour().minute()))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct Lesson_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Lesson(lesson: CampusDualKit.Lesson.example)
                .preferredColorScheme(.light)
                .environmentObject(Settings())
            Lesson(lesson: CampusDualKit.Lesson.example)
                .preferredColorScheme(.dark)
                .environmentObject(Settings())
        }.previewLayout(.sizeThatFits)
    }
}
