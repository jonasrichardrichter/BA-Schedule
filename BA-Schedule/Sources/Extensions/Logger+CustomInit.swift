//
//  Logger+CustomInit.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 19.01.22.
//

import Foundation
import Logging


extension Logger {
    
    /// Custom initializer to use the bundle identifier automatically
    init(for label: String) {
        let bundleIdentifier = Bundle.main.bundleIdentifier
        self.init(label: "\(bundleIdentifier ?? "noBundle").\(label)")
    }
}
