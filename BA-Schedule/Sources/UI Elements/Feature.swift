//
//  Feature.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI

struct Feature: View {
    
    // MARK: - Properties
    
    var systemImage: String
    var iconColor: Color
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32)
                .foregroundColor(iconColor)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
        }
    }
}

// MARK: - Preview
struct Feature_Previews: PreviewProvider {
    static var previews: some View {
        Feature(systemImage: "sun.max", iconColor: .yellow, title: "Oh sunny days!", description: "Now with extra sunshine to make you even happier.")
            .previewLayout(.sizeThatFits)
    }
}
