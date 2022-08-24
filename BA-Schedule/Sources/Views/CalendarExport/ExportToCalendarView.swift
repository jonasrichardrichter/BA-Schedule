//
//  ExportToCalendarView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 22.08.22.
//

import SwiftUI
import EventKit

struct ExportToCalendarView: View {
    @State private var showPermissionSheet = false
    @State private var showErrorSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "calendar.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 62)
                    .foregroundColor(.accentColor)
                Text("Studenplan in den Kalendar exportieren")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Exportieren")
                        .bold()
                        .frame(height: 32)
                        .frame(maxWidth: .infinity)
                }
                    .buttonStyle(.borderedProminent)

            }
                .padding()
                .sheet(isPresented: $showPermissionSheet) {
                    GrantCalendarPermissionView()
                }
                .sheet(isPresented: $showErrorSheet) {
                    
                }
        }
        .onAppear {
            checkPermission()
        }
    }
    
    func checkPermission() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            showPermissionSheet = true
            break
        case .denied, .restricted:
            showErrorSheet = true
            break
        default:
            break
        }
    }
}

struct ExportToCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ExportToCalendarView()
    }
}
