//
//  Warning.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 02.05.22.
//

import SwiftUI

struct Warning: View {
    var body: some View {
        HStack {
            Image(systemName: "wifi.exclamationmark")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 28))
            VStack(alignment: .leading) {
                Text("GENERAL.NOCONNECTION.TITLE")
                    .font(.headline)
                Text("GENERAL.NOCONNECTION.MESSAGE")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color(uiColor: UIColor.systemGroupedBackground))
        .cornerRadius(10)
    }
}

struct Warning_Previews: PreviewProvider {
    static var previews: some View {
        Warning()
    }
}
