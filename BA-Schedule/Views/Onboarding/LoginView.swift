//
//  LoginView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @State private var username: String = ""
    @State private var hash: String = ""
    
    @State private var isLoading: Bool = false
    
    
    // MARK: - View
    
    // TODO: Automatic keyboard focus to first text field
    var body: some View {
        NavigationView {
            Form {
                Section(content: {
                    TextField("ONBOARDING.LOGIN.MATRIKEL", text: $username)
                        .textInputAutocapitalization(.never)
                        .textContentType(.username)
                        
                    SecureField("ONBOARDING.LOGIN.HASH", text: $hash)
                        .textInputAutocapitalization(.never)
                        .textContentType(.password)
                
                    Button("ONBOARDING.LOGIN.BUTTON", action: {
                        self.isLoading = true
                        print("pressed")
                    })
                        .overlay(content: {
                            if isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background()
                            }
                        })
                        .frame(maxWidth: .infinity, alignment: .center)
                }, header: {
                    VStack {
                        Image(systemName: "key.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.accentColor)
                            .frame(height: 70)
                        Text("ONBOARDING.LOGIN.TITLE")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .textCase(.none)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                    }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Link(destination: URL.BaSchedule.informationHash, label: {
                    Image(systemName: "questionmark.circle")
                })
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
