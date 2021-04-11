//
//  EditCredentialsView.swift
//  BA schedule
//
//  Created by Jonas Richard Richter on 20.03.21.
//

import SwiftUI

struct EditCredentialsView: View {
    
    @AppStorage("matrikel") var matrikel:String = ""
    @AppStorage("hash") var hash:String = ""
    
    var body: some View {
            NavigationView {
                VStack {
                    Image(systemName: "person.crop.square.fill.and.at.rectangle")
                        .resizable().scaledToFit().frame(height: 50).foregroundColor(Color("AccentColor")).padding()
                    
                    Text("settings.editcred").font(.largeTitle).fontWeight(.heavy).multilineTextAlignment(.center).padding()
                    
                    Spacer()
                    
                    TextField("settings.editcred.matrikel.label", text: $matrikel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.username)
                        .padding()
                    
                    SecureField("settings.editcred.hash.label", text: $hash)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Spacer()
                    
                }
                .toolbar(content: {
                    Button("settings.editcred.close.label", action: {
                        
                    })
            })
        }
    }
}

struct EditCredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCredentialsView()
    }
}
