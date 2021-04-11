//
//  ScheduleListView.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 22.03.21.
//

import SwiftUI

struct ScheduleListView: View {
    
    @EnvironmentObject var CDConnect: CampusDualConnect
    
    @AppStorage("lastUpdate") var lastUpdate: String?
    
    var body: some View {
        List {
            ForEach(CDConnect.lessonsUnsorted, id: \.self) { lesson in
                HStack {
                    VStack(alignment: .leading) {
                        Text(lesson.title)
                            .font(.headline)
                        HStack {
                            Image(systemName: "person.circle")
                            Text(lesson.instructor)
                                .font(.subheadline)
                        }
                        HStack {
                            Image(systemName: "building.2.crop.circle.fill")
                            Text(lesson.room)
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Text(lesson.getStartToEnd())
                }
            }
            Section {
                Text("app.lastUpdate \(lastUpdate ?? "no update")")
                    .foregroundColor(Color.gray)
                    .font(.footnote)
            }
        }
    }
}

