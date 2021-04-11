//
//  OnboardingView.swift
//  myBA
//
//  Created by Jonas Richard Richter on 22.03.21.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var showingPrivacy = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("onboarding.title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)
                
                Spacer()
                
                VStack(spacing: 24) {
                    Feature(systemName: "list.number", iconColor: Color.blue, title: "onboarding.feature1.title", description: "onboarding.feature1.description")
                    
                    Feature(systemName: "calendar", iconColor: Color.yellow, title: "onboarding.feature2.title", description: "onboarding.feature2.description")
                    
                    Feature(systemName: "doc.text", iconColor: Color.green, title: "onboarding.feature3.title", description: "onboarding.feature3.description")
                    
                }.padding(.leading)

                Spacer()
                
                VStack(alignment: .center) {
                    Image(systemName: "eye.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(Color("AccentColor"))
                    
                    Text("onboarding.privacy.text")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    
                    Button("onboarding.privacy.learnmore"){
                        self.showingPrivacy.toggle()
                    }.font(.footnote)
                }
               
                
                
                NavigationLink(
                    destination: AddCredentialsView(),
                    label: {
                        HStack {
                            Spacer()
                            
                            Text("onboarding.button.continue")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                    })
                    .frame(height: 50)
                    .background(Color("AccentColor"))
                    .cornerRadius(15)
                    .padding(.top)
                    .padding(.bottom)

            }
            .padding()
            .sheet(isPresented: $showingPrivacy) {
                PrivacyView()
                }
            .navigationBarHidden(true)
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
