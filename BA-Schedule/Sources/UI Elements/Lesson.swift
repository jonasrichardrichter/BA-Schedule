//
//  Lesson.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI
import CampusDualKit

struct Lesson: View {
    var lesson: CampusDualKit.Lesson
    
    var body: some View {
        HStack {
            // TODO: Switch color of rounded rectangle based on the module the lessons is part of
            /* RoundedRectangle(cornerRadius: 30)
                .frame(width: 6, height: 40)
                .foregroundColor(.blue) */
            
            VStack(alignment: .leading) {
                Text(lesson.title)
                    .font(.headline)
                HStack {
                    Image(systemName: "building.2.crop.circle")
                    Text(lesson.room)
                }
                    .foregroundColor(.secondary)
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
            Lesson(lesson: CampusDualKit.Lesson.example)
                .preferredColorScheme(.dark)
        }.previewLayout(.sizeThatFits)
    }
}
