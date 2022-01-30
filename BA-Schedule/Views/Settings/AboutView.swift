//
//  AboutView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 03.10.21.
//

import SwiftUI

struct AboutView: View {
    
    var version: String {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        }

    var buildNumber: String {
            Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        }
    
    var body: some View {
        List {
            Section(content: {
                VStack(alignment: .leading) {
                    Text("Icon")
                        .font(.footnote)
                        .fontWeight(.bold)
                    Text("Tri Hartono (The Noun Project)")
                }
            }, header: {
                VStack(alignment: .center) {
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .cornerRadius(30)
                        .padding(.top)
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
        }
        .listStyle(.insetGrouped)
        .navigationTitle("SETTINGS.ABOUT")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
