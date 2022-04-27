//
//  BA_ScheduleApp.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 19.01.22.
//

import SwiftUI

@main
struct BA_ScheduleApp: App {
    // MARK: - Properties
    
    private var settings: Settings
    
    // MARK: - Init
    
    init() {
        self.settings = Settings()
    }
    
    // MARK: - Scene
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
