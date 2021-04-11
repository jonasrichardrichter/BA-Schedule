//
//  ContentView.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 20.03.21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var CDConnect = CampusDualConnect()
    
    @State private var showAbout = false
    
    @AppStorage("showOnboarding") var showOnboardingView = true
    
    var body: some View {
        NavigationView {
            ScheduleListView()
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("app.title")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            // Coming soon!
                            /* Section {
                             NavigationLink(destination: EditCredentialsView()) {
                             Label("settings.editcred", systemImage: "rectangle.and.pencil.and.ellipsis")
                             }
                             
                             NavigationLink(destination: Text("Destination"),
                             label: {
                             Label("settings.calenderexport", systemImage: "calendar")
                             })
                             }*/
                            
                            Section {
                                Button(action: {
                                    self.showAbout = true
                                }) {
                                    Label("settings.about", systemImage: "info.circle")
                                }
                            }
                        }
                        label: {
                            Label("settings.label", systemImage: "gear")
                        }
                    }
                }
        }
        .accentColor(.red)
        .onAppear(perform: {
            if(!showOnboardingView) {
                CDConnect.getTimeTable()
            }
        })
        .sheet(isPresented: $showOnboardingView) {
            OnboardingView()
        }
        .sheet(isPresented: $showAbout) {
            AboutView()
        }
        .environmentObject(CDConnect)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
