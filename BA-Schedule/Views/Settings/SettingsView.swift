//
//  SettingsView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        UIApplication.shared.open(URL.BaSchedule.github)
                        } label: {
                            HStack {
                                Image(systemName: "text.and.command.macwindow")
                                Text("SETTINGS.GITHUB-LINK")
                            }
                        }
                        
                    NavigationLink(destination: {
                        AboutView()
                    }, label: {
                        HStack {
                            Image(systemName: "questionmark.app")
                            Text("SETTINGS.ABOUT")
                        }
                    })
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("SETTINGS")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environment(\.locale, .init(identifier: "de"))
    }
}
