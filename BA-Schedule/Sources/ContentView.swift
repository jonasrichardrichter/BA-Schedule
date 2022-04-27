//
//  ContentView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 19.01.22.
//

import SwiftUI
import CampusDualKit

struct ContentView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var settings: Settings
    
    // MARK: - View
    var body: some View {
        TabView {
            // MARK: - Schedule
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar.day.timeline.leading")
                    Text("SCHEDULE")
                }
            
            // MARK: - Settings
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("SETTINGS")
                }
        }
        // MARK: - Onboarding Sheet
        .fullScreenCover(isPresented: self.$settings.isOnboarded.not, content: {
                OnboardingView()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "de"))
            .environmentObject(Settings())
    }
}
