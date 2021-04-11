//
//  Feature.swift
//  myBA
//
//  Created by Jonas Richard Richter on 25.12.20.
//

import SwiftUI

struct Feature: View {
    var systemName: String
    var iconColor: Color
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    
    var body: some View {
        HStack(spacing: 24) {
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                        .foregroundColor(iconColor)
                            
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(description)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                }
    }
}

struct Feature_Previews: PreviewProvider {
    static var previews: some View {
        Feature(systemName: "terminal.fill", iconColor: Color.blue, title: "Titel", description: "Dies ist eine kurze Beschreibung").padding()
    }
}
