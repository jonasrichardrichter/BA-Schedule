//
//  AboutView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 03.10.21.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    var version: String {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        }
    var buildNumber: String {
            Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        }

    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    VStack(alignment: .leading) {
                        Text("Icon")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text("Tri Hartono (The Noun Project)")
                    }
                    VStack(alignment: .leading) {
                        Text("Made by")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text("Jonas Richard Richter")
                    }
                }, header: {
                    VStack(alignment: .center) {
                        Image("Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                        Text("BA-Schedule")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .textCase(.none)
                        Text("\(version) (\(buildNumber))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                })
                
                Section {
                    Button {
                        UIApplication.shared.open(URL.BaSchedule.github)
                    } label: {
                        Label("SETTINGS.GITHUB-LINK", systemImage: "text.and.command.macwindow")
                    }
                }
                
                Section {
                    Text("Florian Schmidt")
                        .badge("@greybaron")
                } header: {
                    Text("ABOUT.THANKSTO")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("SETTINGS.ABOUT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("GENERAL_CLOSE", systemImage: "xmark")
                    }
                    .buttonStyle(.bordered)
                    .labelStyle(.titleOnly)
                    .buttonBorderShape(.capsule)
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
