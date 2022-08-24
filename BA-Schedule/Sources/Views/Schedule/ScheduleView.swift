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
    @State private var noNetwork: Bool = false
    
    @State private var showCalendarSheet = false
    @State private var showAboutThisApp = false
    @State private var showLoginSheet = false
    
    @EnvironmentObject var settings: Settings
    
    private var logger: Logger = Logger.init(for: "ScheduleView")
    
    var service: ServiceWrapper = ServiceWrapper()
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            ScheduleListView(studyDays: self.$studyDays, lastOnlineUpdate: self.settings.lastOnlineUpdate)
            .navigationTitle("SCHEDULE")
            .onAppear {
                Task {
                    await self.loadSchedule()
                }
            }
            .refreshable {
                await self.loadSchedule(forceUpdate: true)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            showCalendarSheet = true
                        } label: {
                            Label {
                                Text("Stundenplan übertragen")
                            } icon: {
                                Image(systemName: "calendar.badge.plus")
                            }
                        }
                        Divider()
                        Button {
                            UIApplication.shared.open(URL(string: "mailto:kontakt@jonasrichter.eu?subject=Vorschlag%20zu%20BA-Schedule")!)
                        } label: {
                            Label("SETTINGS.IDEAS.BUTTON", systemImage: "envelope")
                        }
                        Divider()
                        Button {
                            showLoginSheet = true
                        } label: {
                            Label("SETTINGS.USER.CHANGELOGIN", systemImage: "person.fill.and.arrow.left.and.arrow.right")
                        }
                        Menu("GENERAL_MENU_MORE") {
                            Button {
                                UIApplication.shared.open(URL.BaSchedule.github)
                            } label: {
                                Label("SETTINGS.GITHUB-LINK", systemImage: "text.and.command.macwindow")
                            }
                            Button {
                                showAboutThisApp = true
                            } label: {
                                Label {
                                    Text("SETTINGS.ABOUT")
                                } icon: {
                                    Image(systemName: "questionmark.app")
                                }
                            }
                        }
                        
                    } label: {
                        Label("SETTINGS.MOREFUNCTIONS.HEADER", systemImage: "ellipsis.circle")
                    }

                }
            }
        }
        .overlay(alignment: .center) {
            if isInitialLoading || !self.settings.isOnboarded {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if noNetwork {
                VStack {
                    ErrorView(systemName: "wifi.exclamationmark", title: "GENERAL.NOCONNECTION.TITLE", message: "GENERAL.NOCONNECTION.MESSAGE")
                    Button("GENERAL.TRYAGAIN") {
                        Task {
                            await self.loadSchedule(forceUpdate: true)
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .sheet(isPresented: $showCalendarSheet) {
            if #available(iOS 16.0, *) {
                ExportToCalendarView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            } else {
                ExportToCalendarView()
            }
        }
        .sheet(isPresented: $showAboutThisApp) {
            AboutView()
        }
        .sheet(isPresented: $showLoginSheet) {
            LoginView()
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
        
        if noNetwork {
            self.noNetwork = false
            self.isInitialLoading = true
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        }
        
        
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
            
            // No connection and lastOnlineUpdate wasn't today triggers loading from storage
            if self.settings.useOfflineSupport {
                do {
                    data = try await self.service.loadFromJson()
                } catch {
                    self.logger.error("An error happened: \(error.localizedDescription)")
                }
            } else {
                self.noNetwork = true
                self.isInitialLoading = false
                self.studyDays = []
                return
            }
        }
        
        self.studyDays = data
        self.isInitialLoading = false
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(Settings())
            .environment(\.locale, .init(identifier: "de"))
    }
}
