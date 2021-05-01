//
//  AboutView.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 23.03.21.
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
            VStack {
                VStack {
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .cornerRadius(30)
                    Text("BA-Schedule")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("\(version) (\(buildNumber))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Made with ❤️ and ☕️ by")
                        .font(.footnote)
                        .fontWeight(.bold)
                    Text("Jonas Richard Richter")
                    
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Icon")
                        .font(.footnote)
                        .fontWeight(.bold)
                    Text("Tri Hartono (The Noun Project)")
                    
                }.padding()
                
                Spacer()
                
            }.padding(.top)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
