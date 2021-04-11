//
//  PrivacyView.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 22.03.21.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        VStack {
            Image(systemName: "eye.circle.fill").resizable().frame(width: 70, height: 70).foregroundColor(Color("AccentColor")).padding()
            Text("privacy.headline")
                .font(.largeTitle).fontWeight(.heavy).padding()
            Spacer()
        }.padding()
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
