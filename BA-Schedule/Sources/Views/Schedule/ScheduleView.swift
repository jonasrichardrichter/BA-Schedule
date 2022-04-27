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
                    ScheduleListView(studyDays: self.studyDays, lastOnlineUpdate: self.settings.lastOnlineUpdate)
                        .navigationTitle("SCHEDULE")
                }
            }
            .onAppear {
                Task {
                    await self.loadSchedule()
                }
            }
            .refreshable {
                await self.loadSchedule(forceUpdate: true)
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
    
    private func loadSchedule(forceUpdate: Bool = false) async {
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
        
        var data: [StudyDay] = []
        
        do {
            if self.settings.useOfflineSupport && Calendar.current.isDateInToday(self.settings.lastOnlineUpdate) && !forceUpdate {
                self.logger.info("Using data from storage.")
                data = try await self.service.loadFromJson()
            } else {
                self.logger.info("Loading data via network.")
                data = try await self.service.loadSchedule(username: username, hash: hash)
                self.settings.lastOnlineUpdate = Date()
            }
        } catch {
            self.logger.error("An error happened: \(error.localizedDescription)")
        }
        
        self.studyDays = data
        self.isInitialLoading = false
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(Settings())
    }
}
