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
        self.useOfflineSupport = UserDefaults.standard.object(forKey: "useOfflineSupport") as? Bool ?? true
        self.lastOnlineUpdate = UserDefaults.standard.object(forKey: "lastOnlineUpdate") as? Date ?? Date(timeIntervalSince1970: 1)
        self.showInstructor = UserDefaults.standard.object(forKey: "showInstructor") as? Bool ?? true
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
    
    // MARK: - Offline Support
    
    @Published var useOfflineSupport: Bool {
        didSet {
            UserDefaults.standard.set(useOfflineSupport, forKey: "useOfflineSupport")
        }
    }
    
    @Published var lastOnlineUpdate: Date {
        didSet {
            UserDefaults.standard.set(lastOnlineUpdate, forKey: "lastOnlineUpdate")
        }
    }
    
    // MARK: - Customization
    
    @Published var showInstructor: Bool {
        didSet {
            UserDefaults.standard.set(showInstructor, forKey: "showInstructor")
        }
    }
    
}
