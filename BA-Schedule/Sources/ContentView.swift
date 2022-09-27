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
            // MARK: - Schedule
        ScheduleView()
        // MARK: - Onboarding Sheet
        .sheet(isPresented: self.$settings.isOnboarded.not, content: {
            OnboardingView()
                .interactiveDismissDisabled()
                .navigationViewStyle(.stack)
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
