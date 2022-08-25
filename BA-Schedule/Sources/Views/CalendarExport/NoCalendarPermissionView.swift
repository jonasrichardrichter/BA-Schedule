//
//  NoCalendarPermissionView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 24.08.22.
//

import SwiftUI

struct NoCalendarPermissionView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "xmark.diamond")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 86)
                    .foregroundColor(.red)
                Text("Der Zugriff auf den Kalender ist nicht möglich.")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Spacer()
                    
            }
        }
    }
}

struct NoCalendarPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NoCalendarPermissionView()
    }
}
