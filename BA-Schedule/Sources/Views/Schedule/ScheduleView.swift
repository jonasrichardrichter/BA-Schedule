//
//  ScheduleView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI
import CampusDualKit
import Logging

struct ScheduleView: View {
    
    // MARK: - Properties
    
    @State private var studyDays: [StudyDay] = []
    @State private var isInitialLoading: Bool = true
    
    @EnvironmentObject var settings: Settings
    
    private var logger: Logger = Logger.init(for: "ScheduleView")
    
    var service: ServiceWrapper = ServiceWrapper()
    
    // MARK: - Views
    
    var body: some View {
        if self.settings.isOnboarded {
            NavigationView {
                if isInitialLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .navigationTitle("SCHEDULE")
                } else {
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
                    .listStyle(.plain)
                    .navigationTitle("SCHEDULE")
                }
            }
            .onAppear {
                self.loadSchedule()
            }
            .refreshable {
                self.loadSchedule()
            }
        } else {
            NavigationView {
                ProgressView()
                    .progressViewStyle(.circular)
                .navigationTitle("SCHEDULE")
            }
        }
    }
    
    // MARK: - Functions
    
    private func loadSchedule() {
        // Check if user is onboarded
        guard settings.isOnboarded == true else {
            self.logger.debug("User is not onboarded. No data is loaded.")
            return
        }
        
        self.logger.debug("Start loading schedule")
        
        // Get credentials for login
        guard let username = self.settings.username else {
            return
        }
        guard let hash = self.settings.hash else {
            return
        }
        
        self.service.loadSchedule(username: username, hash: hash) { (result: Result<[StudyDay], ScheduleServiceError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.studyDays = data
                    self.isInitialLoading = false
                }
            case .failure(let error):
                self.logger.error("An error happened: \(error.localizedDescription)")
            }
        }
        
        
    }
    
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(Settings())
    }
}
