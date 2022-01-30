//
//  Settings.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import Foundation
import SwiftUI
import Combine
import KeychainItem

class Settings: ObservableObject {
    
    init() {
        self.isOnboarded = UserDefaults.standard.object(forKey: "isOnboarded") as? Bool ?? false
        self.lastVersionUsed = UserDefaults.standard.object(forKey: "lastVersionUsed") as? String ??  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    // MARK: - Login information
    
    @KeychainItem(account: "de.ba-sachsen.campus-dual.matrikelnummer")
    var username: String?
    
    @KeychainItem(account: "de.ba-sachsen.campus-dual.hash")
    var hash: String?
    
    // MARK: - Internal information
    
    @Published var isOnboarded: Bool {
        didSet {
            UserDefaults.standard.set(isOnboarded, forKey: "isOnboarded")
        }
    }
    
    @Published var lastVersionUsed: String {
        didSet {
            UserDefaults.standard.set(lastVersionUsed, forKey: "lastVersionUsed")
        }
    }
}
