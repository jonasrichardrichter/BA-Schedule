//
//  OnboardingView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("WELCOME_MESSAGE")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                VStack(spacing: 40) {
                    Feature(systemImage: "sun.max.fill", iconColor: .yellow, title: "Oh sunny days!", description: "Now with extra sunshine to make you even happier.")
                    
                    Feature(systemImage: "sun.max.fill", iconColor: .yellow, title: "Oh sunny days!", description: "Now with extra sunshine to make you even happier.")
                    
                    Feature(systemImage: "sun.max.fill", iconColor: .yellow, title: "Oh sunny days!", description: "Now with extra sunshine to make you even happier.")
                }
                
                Spacer()
                
                NavigationLink(destination: {
                    LoginView()
                        .navigationBarTitleDisplayMode(.inline)
                }, label: {
                    HStack {
                        Spacer()
                        
                        Text("Fortfahren")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                }).padding()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environment(\.locale, .init(identifier: "de"))
    }
}
