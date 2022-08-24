//
//  GrantCalendarPermissionView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 22.08.22.
//

import SwiftUI
import EventKit

struct GrantCalendarPermissionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 82)
                        .foregroundColor(.blue)
                    Text("PERMISSON.CALENDAR.TITLE")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("PERMISSON.CALENDAR.DESCR")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }.padding()
                
                Spacer()
                
                VStack {
                    Button {
                        self.requestAccess()
                    } label: {
                        Label {
                            Text("Zugriff erteilen")
                        } icon: {
                            Image(systemName: "checkmark.circle")
                        }

                    }
                    .tint(.blue)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
    }
    
    func requestAccess() {
        let store = EKEventStore()
        
        store.requestAccess(to: .event) { granted, error in
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct GrantCalendarPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        GrantCalendarPermissionView()
            .environment(\.locale, .init(identifier: "de"))
    }
}
