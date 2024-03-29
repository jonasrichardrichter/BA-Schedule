//
//  LoginView.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import SwiftUI
import CampusDualKit

struct LoginView: View {
    
    // MARK: - Properties
    
    var callback: () -> ()?
    
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var hash: String = ""
    
    @State private var isLoading: Bool = false
    
    @State private var showingError: Bool = false
    @State private var errorToShow: ScheduleServiceError?
    
    // MARK: - View
    
    // TODO: Automatic keyboard focus to first text field
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("ONBOARDING.LOGIN.MATRIKEL", text: $username)
                        .textInputAutocapitalization(.never)
                        .textContentType(.username)
                        .keyboardType(.numberPad)
                        
                    SecureField("ONBOARDING.LOGIN.HASH", text: $hash)
                        .textInputAutocapitalization(.never)
                        .textContentType(.password)
                } header: {
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
                            .lineLimit(nil)
                            .foregroundColor(.primary)
                    }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                
                Section {
                    // MARK: - Button
                    if !isLoading {
                        Button("ONBOARDING.LOGIN.BUTTON", action: {
                            self.isLoading = true
                            self.doLogin()
                        })
                            .frame(maxWidth: .infinity, alignment: .center)
                            .alert("LOGIN_ERROR_TITLE", isPresented: $showingError) {
                                Button("ALERT_BUTTON_CANCEL", role: .cancel) { }
                                
                            } message: {
                                Text(self.errorToShow?.localizedDescription ?? "")
                            }

                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Link(destination: URL.BaSchedule.informationHash, label: {
                        Label("More information", systemImage: "questionmark.circle")
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)

    }
    
    // MARK: - Functions
    
    func doLogin() {
      let service = ServiceWrapper()
        service.checkCredentials(username: self.username, hash: self.hash) { (result: Result<Bool, ScheduleServiceError>) in
            switch result {
            case .success(_):
                self.isLoading = false
                self.saveLoginCredentialsAndFinishOnboarding(username: username, hash: hash)
            case .failure(let failure):
                self.isLoading = false
                self.showingError = true
                self.errorToShow = failure
            }
        }
    }
    
    func saveLoginCredentialsAndFinishOnboarding(username: String, hash: String) {
        DispatchQueue.main.async {
            self.settings.username = username
            self.settings.hash = hash
            self.settings.isOnboarded = true
            self.callback()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(callback: {
            print("Logged In")
        })
            .environmentObject(Settings())
    }
}
