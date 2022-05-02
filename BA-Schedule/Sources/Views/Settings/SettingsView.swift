//
//  SettingsView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var settings: Settings
    
    @State private var showLogin = false
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            List {
                
                // MARK: - User
                Section {
                    if self.settings.isOnboarded {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.checkmark")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .padding(.vertical)
                                .symbolRenderingMode(.multicolor)
                            VStack(alignment: .leading) {
                                Text("SETTINGS.LOGGEDIN.TITLE")
                                    .font(.callout)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                Text("Matrikel: \(settings.username ?? "unknown")")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                    } else {
                        Button {
                            self.showLogin = true
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .padding(.vertical)
                                    .symbolRenderingMode(.multicolor)
                                VStack(alignment: .center) {
                                    Text("SETTINGS.NOTLOGGEDIN.TITLE")
                                        .font(.callout)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                    Text("SETTINGS.NOTLOGGEDIN.DESCR")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                            }
                        }
                        .buttonStyle(.plain)
                        .sheet(isPresented: self.$showLogin) {
                            LoginView()
                        }
                    }
                }
                
                // MARK: - More Functions
                
                Section {
                    Toggle(isOn: self.$settings.useOfflineSupport) {
                        Label("SETTINGS.MOREFUNCTIONS.OFFLINESUPPORT", systemImage: "internaldrive")
                    }
                } header: {
                    Text("SETTINGS.MOREFUNCTIONS.HEADER")
                }
                
                
                // MARK: - About
                Section {
                    Button {
                        UIApplication.shared.open(URL.BaSchedule.github)
                    } label: {
                        Label("SETTINGS.GITHUB-LINK", systemImage: "text.and.command.macwindow")
                    }
                    
                    NavigationLink(destination: {
                        AboutView()
                    }, label: {
                        Label("SETTINGS.ABOUT", systemImage: "questionmark.app")
                            .foregroundColor(.primary)
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
            .environmentObject(Settings())
    }
}
