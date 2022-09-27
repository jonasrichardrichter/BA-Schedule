//
//  URL+BA-Schedule.swift
//  BA-Schedule
//
//  Created by Jonas Richard Richter on 30.01.22.
//

import Foundation

internal extension URL {
    enum BaSchedule {
        static let github = URL(string: "https://github.com/jonasrichardrichter/BA-Schedule/")!
        static let informationHash = URL(string: "blob/main/LOGIN_INFORMATION.md", relativeTo: Self.github)!
    }
}
