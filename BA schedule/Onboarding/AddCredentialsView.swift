//
//  AddCredentialsView.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 23.03.21.
//

import SwiftUI
import KeychainSwift

struct AddCredentialsView: View {
    
    let keychain = KeychainSwift()
    
    @State var matrikel: String = ""
    @State var hash: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.square.fill.and.at.rectangle")
                .resizable().scaledToFit().frame(height: 50).foregroundColor(Color("AccentColor")).padding()
            
            Text("onboarding.addCred.title").font(.largeTitle).fontWeight(.heavy).multilineTextAlignment(.center).padding()
            
            Spacer()
            
            TextField("onboarding.addCred.matrikel.label", text: $matrikel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.username)
                .padding()
            
            SecureField("onboarding.addCred.hash.label", text: $hash)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer()
            LargeButton(content: {
                Text("onboarding.addCred.loginButton")
            }, action: {
                UserDefaults.standard.set(false, forKey: "showOnboarding")
                keychain.set(matrikel, forKey: "matrikel")
                keychain.set(hash, forKey: "hash")
            })
            
        }.padding()
    }
}

struct AddCredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        AddCredentialsView()
    }
}
