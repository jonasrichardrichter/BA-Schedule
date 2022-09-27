//
//  ErrorView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 02.05.22.
//

import SwiftUI

struct ErrorView: View {
    public var systemName: String
    public var color: Color? = .primary
    public var title: LocalizedStringKey
    public var message: LocalizedStringKey
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .font(.system(size: 46))
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(color)
                .padding()
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(systemName: "wifi.exclamationmark", title: "GENERAL.NOCONNECTION.TITLE", message: "GENERAL.NOCONNECTION.MESSAGE")
    }
}
