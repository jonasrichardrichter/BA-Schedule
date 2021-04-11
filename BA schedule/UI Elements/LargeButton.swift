//
//  LargeButton.swift
//  myBA
//
//  Created by Jonas Richard Richter on 10.11.20.
//

import SwiftUI

struct LargeButton<Content: View>: View {
    
    var content: () -> Content

    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                
                content()
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .frame(height: 50)
        .background(Color("AccentColor"))
        .cornerRadius(15)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(content: {
            Text("Test Button")
        }, action: {} )
    }
}
