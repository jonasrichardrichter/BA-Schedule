//
//  NoCalendarPermissionView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 24.08.22.
//

import SwiftUI

struct NoCalendarPermissionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ErrorView(systemName: "xmark.diamond", color: .red, title: "ERROR_NO_CALENDAR_ACCESS", message: "ERROR_NO_CALENDAR_ACCESS_DESCR")
                Spacer()
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } label: {
                    Label("ERROR_NO_CALENDAR_ACCESS_TO_SETTINGS", systemImage: "gear")
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("GENERAL_CLOSE", systemImage: "xmark")
                    }
                    .labelStyle(.titleOnly)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)

                }
            }
        }
    }
}

struct NoCalendarPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NoCalendarPermissionView()
            .environment(\.locale, .init(identifier: "de"))
    }
}
